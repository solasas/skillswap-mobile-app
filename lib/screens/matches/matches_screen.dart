import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/empty_state.dart';
import '../../models/match_result.dart';
import '../../providers/matches_provider.dart';

class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({super.key});

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen>
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
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Mutual'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MatchList(provider: allMatchesProvider),
          _MatchList(provider: mutualMatchesProvider),
        ],
      ),
    );
  }
}

class _MatchList extends ConsumerWidget {
  const _MatchList({required this.provider});

  final AutoDisposeFutureProvider<List<MatchResult>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matches = ref.watch(provider);
    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(provider),
      child: AsyncValueWidget<List<MatchResult>>(
        value: matches,
        onRetry: () => ref.invalidate(provider),
        data: (list) {
          if (list.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 120),
                EmptyState(
                  icon: Icons.people_outline,
                  message:
                      'No matches yet. Add more skills to your profile\nto find people to swap with.',
                ),
              ],
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final match = list[index];
              return _MatchCard(match: match);
            },
          );
        },
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({required this.match});

  final MatchResult match;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/matches/${match.user.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                child: Text(
                  match.user.name.isNotEmpty
                      ? match.user.name[0].toUpperCase()
                      : '?',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            match.user.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        if (match.isMutual)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'MUTUAL',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                    letterSpacing: 0.4,
                                  ),
                            ),
                          ),
                      ],
                    ),
                    if (match.user.city != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        match.user.city!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                    if (match.skillsTheyCanTeachYou.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Can teach you: ${match.skillsTheyCanTeachYou.map((s) => s.name).join(', ')}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
