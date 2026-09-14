import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/status_badge.dart';
import '../../models/skill_exchange.dart';
import '../../providers/exchanges_provider.dart';

class ExchangesScreen extends ConsumerStatefulWidget {
  const ExchangesScreen({super.key});

  @override
  ConsumerState<ExchangesScreen> createState() => _ExchangesScreenState();
}

class _ExchangesScreenState extends ConsumerState<ExchangesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swap requests'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Received'), Tab(text: 'Sent')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ExchangeList(provider: receivedExchangesProvider, emptyMessage: 'No requests received yet.'),
          _ExchangeList(provider: sentExchangesProvider, emptyMessage: "You haven't sent any requests yet."),
        ],
      ),
    );
  }
}

class _ExchangeList extends ConsumerWidget {
  const _ExchangeList({required this.provider, required this.emptyMessage});

  final AutoDisposeFutureProvider<List<SkillExchange>> provider;
  final String emptyMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exchangesAsync = ref.watch(provider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(provider),
      child: AsyncValueWidget<List<SkillExchange>>(
        value: exchangesAsync,
        onRetry: () => ref.invalidate(provider),
        data: (exchanges) {
          if (exchanges.isEmpty) {
            return ListView(
              children: [
                const SizedBox(height: 120),
                EmptyState(icon: Icons.inbox_outlined, message: emptyMessage),
              ],
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: exchanges.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _ExchangeCard(exchange: exchanges[index]),
          );
        },
      ),
    );
  }
}

class _ExchangeCard extends StatelessWidget {
  const _ExchangeCard({required this.exchange});

  final SkillExchange exchange;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/requests/${exchange.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${exchange.requester.name} ↔ ${exchange.receiver.name}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  StatusBadge.exchange(exchange.status),
                ],
              ),
              const SizedBox(height: 8),
              Text('Offers: ${exchange.offeredSkill.name}'),
              Text('Wants: ${exchange.wantedSkill.name}'),
            ],
          ),
        ),
      ),
    );
  }
}
