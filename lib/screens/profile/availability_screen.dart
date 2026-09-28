import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/network/api_exception.dart';
import '../../core/utils/enums.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../models/availability.dart';
import '../../providers/availability_provider.dart';
import '../../providers/core_providers.dart';

class AvailabilityScreen extends ConsumerWidget {
  const AvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Availability'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddSlotSheet(context, ref),
            tooltip: 'Add availability',
          ),
        ],
      ),
      body: ref.watch(myAvailabilityProvider).when(
        data: (slots) {
          if (slots.isEmpty) {
            return Center(
              child: Text(
                'No availability set yet',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: WeekDay.values.length,
            itemBuilder: (context, dayIndex) {
              final day = WeekDay.values[dayIndex];
              final daySlots = slots.where((s) => s.dayOfWeek == day).toList();
              return _DaySection(
                day: day,
                slots: daySlots,
                onDelete: (id) => _deleteSlot(context, ref, id),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading availability: $error'),
        ),
      ),
    );
  }

  Future<void> _deleteSlot(BuildContext context, WidgetRef ref, int id) async {
    try {
      await ref.read(availabilityRepositoryProvider).removeAvailability(id);
      ref.invalidate(myAvailabilityProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Availability slot removed')),
        );
      }
    } on ApiException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    }
  }

  Future<void> _showAddSlotSheet(BuildContext context, WidgetRef ref) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _AddSlotSheet(
        onAdd: (dayOfWeek, startTime, endTime) async {
          try {
            await ref.read(availabilityRepositoryProvider).addAvailability(
              dayOfWeek: dayOfWeek,
              startTime: startTime,
              endTime: endTime,
            );
            ref.invalidate(myAvailabilityProvider);
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Availability added')),
              );
            }
          } on ApiException catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.message)),
              );
            }
          }
        },
      ),
    );
  }
}

class _DaySection extends StatelessWidget {
  const _DaySection({
    required this.day,
    required this.slots,
    required this.onDelete,
  });

  final WeekDay day;
  final List<Availability> slots;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            day.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ...slots.map((slot) => _SlotCard(slot: slot, onDelete: onDelete)),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SlotCard extends StatelessWidget {
  const _SlotCard({required this.slot, required this.onDelete});

  final Availability slot;
  final Function(int) onDelete;

  TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final startTime = _parseTime(slot.startTime);
    final endTime = _parseTime(slot.endTime);
    final startStr = startTime.format(context);
    final endStr = endTime.format(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          '$startStr – $endStr',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline,
            size: 20,
            color: theme.colorScheme.error,
          ),
          onPressed: () => onDelete(slot.id),
          splashRadius: 24,
        ),
      ),
    );
  }
}

class _AddSlotSheet extends ConsumerStatefulWidget {
  const _AddSlotSheet({required this.onAdd});

  final Future<void> Function(WeekDay, TimeOfDay, TimeOfDay) onAdd;

  @override
  ConsumerState<_AddSlotSheet> createState() => _AddSlotSheetState();
}

class _AddSlotSheetState extends ConsumerState<_AddSlotSheet> {
  WeekDay _selectedDay = WeekDay.monday;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _submitting = false;

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) setState(() => _startTime = picked);
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? const TimeOfDay(hour: 17, minute: 0),
    );
    if (picked != null) setState(() => _endTime = picked);
  }

  void _submit() async {
    if (_startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both start and end times')),
      );
      return;
    }

    if (_startTime!.hour > _endTime!.hour ||
        (_startTime!.hour == _endTime!.hour && _startTime!.minute >= _endTime!.minute)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Start time must be before end time')),
      );
      return;
    }

    setState(() => _submitting = true);
    try {
      await widget.onAdd(_selectedDay, _startTime!, _endTime!);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Availability',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Day of Week',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<WeekDay>(
              segments: WeekDay.values
                  .map((day) => ButtonSegment(label: Text(day.label[0]), value: day))
                  .toList(),
              selected: {_selectedDay},
              onSelectionChanged: (Set<WeekDay> newSelection) {
                setState(() => _selectedDay = newSelection.first);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Time',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: _pickStartTime,
                        child: Text(
                          _startTime?.format(context) ?? 'Select time',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Time',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: _pickEndTime,
                        child: Text(
                          _endTime?.format(context) ?? 'Select time',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Add Availability'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
