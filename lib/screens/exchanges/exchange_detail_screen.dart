import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/network/api_exception.dart';
import '../../core/utils/enums.dart';
import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/status_badge.dart';
import '../../models/session.dart';
import '../../models/skill_exchange.dart';
import '../../providers/auth_provider.dart';
import '../../providers/core_providers.dart';
import '../../providers/exchanges_provider.dart';
import '../../providers/sessions_provider.dart';

class ExchangeDetailScreen extends ConsumerStatefulWidget {
  const ExchangeDetailScreen({super.key, required this.exchangeId});

  final int exchangeId;

  @override
  ConsumerState<ExchangeDetailScreen> createState() => _ExchangeDetailScreenState();
}

class _ExchangeDetailScreenState extends ConsumerState<ExchangeDetailScreen> {
  bool _acting = false;

  Future<void> _act(Future<SkillExchange> Function() action) async {
    setState(() => _acting = true);
    try {
      await action();
      invalidateExchanges(ref);
      ref.invalidate(exchangeDetailProvider(widget.exchangeId));
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      if (mounted) setState(() => _acting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final exchangeAsync = ref.watch(exchangeDetailProvider(widget.exchangeId));
    final myId = ref.watch(authProvider).userId;

    return Scaffold(
      appBar: AppBar(title: const Text('Swap request')),
      body: AsyncValueWidget<SkillExchange>(
        value: exchangeAsync,
        onRetry: () => ref.invalidate(exchangeDetailProvider(widget.exchangeId)),
        data: (exchange) => _buildBody(context, exchange, myId),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SkillExchange exchange, int? myId) {
    final isReceiver = exchange.receiver.id == myId;
    final isParticipant = exchange.receiver.id == myId || exchange.requester.id == myId;
    final repo = ref.read(exchangesRepositoryProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(child: Text('${exchange.requester.name} ↔ ${exchange.receiver.name}', style: Theme.of(context).textTheme.titleLarge)),
            StatusBadge.exchange(exchange.status),
          ],
        ),
        const SizedBox(height: 16),
        _InfoRow(label: 'Offered skill', value: exchange.offeredSkill.name),
        _InfoRow(label: 'Wanted skill', value: exchange.wantedSkill.name),
        if (exchange.message != null && exchange.message!.isNotEmpty)
          _InfoRow(label: 'Message', value: exchange.message!),
        if (exchange.createdAt != null)
          _InfoRow(label: 'Requested', value: DateFormat.yMMMd().add_jm().format(exchange.createdAt!)),
        const SizedBox(height: 24),
        if (isReceiver && exchange.status == ExchangeStatus.pending) ...[
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _acting ? null : () => _act(() => repo.reject(exchange.id)),
                  child: const Text('Reject'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _acting ? null : () => _act(() => repo.accept(exchange.id)),
                  child: const Text('Accept'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        if (isParticipant && exchange.status == ExchangeStatus.accepted) ...[
          FilledButton.tonalIcon(
            onPressed: _acting ? null : () => _act(() => repo.complete(exchange.id)),
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Mark exchange completed'),
          ),
          const SizedBox(height: 16),
        ],
        const Divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sessions', style: Theme.of(context).textTheme.titleMedium),
            if (isParticipant &&
                (exchange.status == ExchangeStatus.accepted || exchange.status == ExchangeStatus.completed))
              TextButton.icon(
                onPressed: () => context.push('/requests/${exchange.id}/schedule'),
                icon: const Icon(Icons.add),
                label: const Text('Schedule'),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Consumer(
          builder: (context, ref, _) {
            final sessionsAsync = ref.watch(exchangeSessionsProvider(exchange.id));
            return AsyncValueWidget<List<Session>>(
              value: sessionsAsync,
              onRetry: () => ref.invalidate(exchangeSessionsProvider(exchange.id)),
              data: (sessions) {
                if (sessions.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('No sessions scheduled yet.', style: TextStyle(color: Colors.grey)),
                  );
                }
                return Column(
                  children: sessions
                      .map((s) => Card(
                            child: ListTile(
                              onTap: () => context.push('/sessions/${s.id}'),
                              leading: Icon(s.mode == SessionMode.online ? Icons.videocam_outlined : Icons.place_outlined),
                              title: Text(DateFormat.yMMMd().add_jm().format(s.dateTime)),
                              subtitle: Text('${s.durationMinutes} min · ${s.mode.label}'),
                              trailing: StatusBadge.session(s.status),
                            ),
                          ))
                      .toList(),
                );
              },
            );
          },
        ),
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
            child: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.outline)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
