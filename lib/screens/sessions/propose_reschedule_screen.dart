import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/api_exception.dart';
import '../../core/widgets/section_label.dart';
import '../../providers/core_providers.dart';
import '../../providers/reschedule_provider.dart';

class ProposeRescheduleScreen extends ConsumerStatefulWidget {
  const ProposeRescheduleScreen({super.key, required this.sessionId});

  final int sessionId;

  @override
  ConsumerState<ProposeRescheduleScreen> createState() =>
      _ProposeRescheduleScreenState();
}

class _ProposeRescheduleScreenState extends ConsumerState<ProposeRescheduleScreen> {
  DateTime? _date;
  TimeOfDay? _time;
  final _reasonController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _reasonController.dispose();
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
      setState(() => _error = 'Pick both a date and time.');
      return;
    }

    final proposedDateTime = DateTime(
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
      await ref.read(rescheduleRepositoryProvider).proposeReschedule(
        sessionId: widget.sessionId,
        proposedDateTime: proposedDateTime,
        reason: _reasonController.text.trim(),
      );
      invalidateRescheduleProviders(ref, widget.sessionId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reschedule proposal sent')),
        );
        Navigator.pop(context);
      }
    } on ApiException catch (e) {
      if (mounted) {
        setState(() => _error = e.message);
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Propose new time')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionLabel('Select new date and time'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _pickDate,
                  child: Text(
                    _date == null
                        ? 'Pick date'
                        : '${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _pickTime,
                  child: Text(
                    _time == null ? 'Pick time' : _time!.format(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionLabel('Reason (optional)'),
          const SizedBox(height: 8),
          TextField(
            controller: _reasonController,
            decoration: InputDecoration(
              hintText: 'Why do you need to reschedule?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          if (_error != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          FilledButton(
            onPressed: _submitting ? null : _submit,
            child: _submitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Propose reschedule'),
          ),
        ],
      ),
    );
  }
}
