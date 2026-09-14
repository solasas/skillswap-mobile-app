import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/section_label.dart';
import '../../core/widgets/star_rating.dart';
import '../../models/match_result.dart';
import '../../providers/matches_provider.dart';
import '../../providers/ratings_provider.dart';

class MatchDetailScreen extends ConsumerWidget {
  const MatchDetailScreen({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchAsync = ref.watch(matchDetailProvider(userId));
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: AsyncValueWidget<MatchResult>(
        value: matchAsync,
        onRetry: () => ref.invalidate(matchDetailProvider(userId)),
        data: (match) => _MatchDetailBody(match: match),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton.icon(
            icon: const Icon(Icons.swap_horiz),
            label: const Text('Send swap request'),
            onPressed: () => context.push('/matches/$userId/request'),
          ),
        ),
      ),
    );
  }
}

class _MatchDetailBody extends ConsumerWidget {
  const _MatchDetailBody({required this.match});

  final MatchResult match;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(userRatingSummaryProvider(match.user.id));
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 32,
              child: Text(
                match.user.name.isNotEmpty
                    ? match.user.name[0].toUpperCase()
                    : '?',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    match.user.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (match.user.city != null) Text(match.user.city!),
                  const SizedBox(height: 4),
                  summaryAsync.when(
                    data: (s) => s.totalRatings == 0
                        ? Text(
                            'No ratings yet',
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                          )
                        : Row(
                            children: [
                              StarRatingDisplay(stars: s.averageStars),
                              const SizedBox(width: 6),
                              Text(
                                '${s.averageStars.toStringAsFixed(1)} (${s.totalRatings})',
                              ),
                            ],
                          ),
                    loading: () => const SizedBox(height: 18),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (match.user.bio != null) ...[
          const SizedBox(height: 20),
          const SectionLabel('About'),
          const SizedBox(height: 6),
          Text(match.user.bio!),
        ],
        const SizedBox(height: 24),
        const SectionLabel('Can teach you'),
        const SizedBox(height: 8),
        _SkillChips(
          skills: match.skillsTheyCanTeachYou.map((s) => s.name).toList(),
        ),
        const SizedBox(height: 20),
        const SectionLabel('Wants to learn from you'),
        const SizedBox(height: 8),
        _SkillChips(
          skills: match.skillsYouCanTeachThem.map((s) => s.name).toList(),
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          icon: const Icon(Icons.star_outline),
          label: const Text('View reputation'),
          onPressed: () => context.push('/users/${match.user.id}/ratings'),
        ),
      ],
    );
  }
}

class _SkillChips extends StatelessWidget {
  const _SkillChips({required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    if (skills.isEmpty) {
      return Text('None yet', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant));
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills.map((s) => Chip(label: Text(s))).toList(),
    );
  }
}
