import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/network/api_exception.dart';
import '../../core/utils/enums.dart';
import '../../core/widgets/auth_error_banner.dart';
import '../../core/widgets/section_label.dart';
import '../../providers/core_providers.dart';
import '../../providers/sessions_provider.dart';

class ScheduleSessionScreen extends ConsumerStatefulWidget {
  const ScheduleSessionScreen({super.key, required this.exchangeId});

  final int exchangeId;

  @override
  ConsumerState<ScheduleSessionScreen> createState() =>
      _ScheduleSessionScreenState();
}

class _ScheduleSessionScreenState extends ConsumerState<ScheduleSessionScreen> {
  DateTime? _date;
  TimeOfDay? _time;
  final _durationController = TextEditingController(text: '60');
  SessionMode _mode = SessionMode.online;
  final _meetLinkController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _durationController.dispose();
    _meetLinkController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _submit() async {
    if (_date == null || _time == null) {
      setState(() => _error = 'Pick a date and time.');
      return;
    }
    final duration = int.tryParse(_durationController.text.trim());
    if (duration == null || duration <= 0) {
      setState(() => _error = 'Enter a valid duration in minutes.');
      return;
    }
    if (_mode == SessionMode.online &&
        _meetLinkController.text.trim().isEmpty) {
      setState(() => _error = 'Add a meeting link for an online session.');
      return;
    }
    if (_mode == SessionMode.offline &&
        _locationController.text.trim().isEmpty) {
      setState(() => _error = 'Add a location for an in-person session.');
      return;
    }

    final dateTime = DateTime(
      _date!.year,
      _date!.month,
      _date!.day,
      _time!.hour,
      _time!.minute,
    );
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(sessionsRepositoryProvider)
          .createSession(
            exchangeId: widget.exchangeId,
            dateTime: dateTime,
            durationMinutes: duration,
            mode: _mode,
            meetLink: _mode == SessionMode.online
                ? _meetLinkController.text.trim()
                : null,
            location: _mode == SessionMode.offline
                ? _locationController.text.trim()
                : null,
            notes: _notesController.text.trim(),
          );
      ref.invalidate(exchangeSessionsProvider(widget.exchangeId));
      ref.invalidate(mySessionsProvider);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Session scheduled!')));
        context.pop();
      }
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule session')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_error != null) ...[
            AuthErrorBanner(_error!),
            const SizedBox(height: 16),
          ],
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today_outlined),
            title: Text(
              _date == null ? 'Pick a date' : DateFormat.yMMMd().format(_date!),
            ),
            onTap: _pickDate,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.access_time),
            title: Text(_time == null ? 'Pick a time' : _time!.format(context)),
            onTap: _pickTime,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _durationController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Duration (minutes)'),
          ),
          const SizedBox(height: 16),
          const SectionLabel('Mode'),
          const SizedBox(height: 8),
          SegmentedButton<SessionMode>(
            segments: const [
              ButtonSegment(
                value: SessionMode.online,
                label: Text('Online'),
                icon: Icon(Icons.videocam_outlined),
              ),
              ButtonSegment(
                value: SessionMode.offline,
                label: Text('In person'),
                icon: Icon(Icons.place_outlined),
              ),
            ],
            selected: {_mode},
            onSelectionChanged: (selection) =>
                setState(() => _mode = selection.first),
          ),
          const SizedBox(height: 16),
          if (_mode == SessionMode.online)
            TextField(
              controller: _meetLinkController,
              decoration: const InputDecoration(labelText: 'Meeting link'),
            )
          else
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
          const SizedBox(height: 16),
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Notes (optional)'),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _submitting ? null : _submit,
            child: _submitting
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : const Text('Schedule session'),
          ),
        ],
      ),
    );
  }
}
