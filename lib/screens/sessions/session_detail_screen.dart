import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/network/api_exception.dart';
import '../../core/utils/enums.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/status_badge.dart';
import '../../models/session.dart';
import '../../providers/auth_provider.dart';
import '../../providers/core_providers.dart';
import '../../providers/sessions_provider.dart';

class SessionDetailScreen extends ConsumerStatefulWidget {
  const SessionDetailScreen({super.key, required this.sessionId});

  final int sessionId;

  @override
  ConsumerState<SessionDetailScreen> createState() =>
      _SessionDetailScreenState();
}

class _SessionDetailScreenState extends ConsumerState<SessionDetailScreen> {
  bool _acting = false;

  Future<void> _act(Future<Session> Function() action) async {
    setState(() => _acting = true);
    try {
      await action();
      ref.invalidate(sessionDetailProvider(widget.sessionId));
      ref.invalidate(mySessionsProvider);
    } on ApiException catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _acting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(sessionDetailProvider(widget.sessionId));
    final myId = ref.watch(authProvider).userId;

    return Scaffold(
      appBar: AppBar(title: const Text('Session')),
      body: AsyncValueWidget<Session>(
        value: sessionAsync,
        onRetry: () => ref.invalidate(sessionDetailProvider(widget.sessionId)),
        data: (session) => _buildBody(context, session, myId),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Session session, int? myId) {
    final exchange = session.exchange;
    final isParticipant =
        exchange.requester.id == myId || exchange.receiver.id == myId;
    final isScheduler = session.scheduledBy.id == myId;
    final repo = ref.read(sessionsRepositoryProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                DateFormat.yMMMEd().add_jm().format(session.dateTime),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            StatusBadge.session(session.status),
          ],
        ),
        const SizedBox(height: 16),
        _InfoRow(
          label: 'Exchange',
          value: '${exchange.offeredSkill.name} ↔ ${exchange.wantedSkill.name}',
        ),
        _InfoRow(
          label: 'Duration',
          value: '${session.durationMinutes} minutes',
        ),
        _InfoRow(label: 'Mode', value: session.mode.label),
        if (session.meetLink != null && session.meetLink!.isNotEmpty)
          _InfoRow(label: 'Meeting link', value: session.meetLink!),
        if (session.location != null && session.location!.isNotEmpty)
          _InfoRow(label: 'Location', value: session.location!),
        if (session.notes != null && session.notes!.isNotEmpty)
          _InfoRow(label: 'Notes', value: session.notes!),
        _InfoRow(label: 'Scheduled by', value: session.scheduledBy.name),
        const SizedBox(height: 24),
        if (isParticipant && session.status == SessionStatus.scheduled) ...[
          Row(
            children: [
              if (isScheduler) ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: _acting
                        ? null
                        : () => _act(() => repo.cancel(session.id)),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: FilledButton(
                  onPressed: _acting
                      ? null
                      : () => _act(() => repo.complete(session.id)),
                  child: const Text('Mark completed'),
                ),
              ),
            ],
          ),
        ],
        if (isParticipant && session.status == SessionStatus.completed) ...[
          FilledButton.icon(
            icon: const Icon(Icons.star_outline),
            label: const Text('Rate this session'),
            onPressed: () => context.push('/sessions/${session.id}/rate'),
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
