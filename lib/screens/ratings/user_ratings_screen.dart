import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/widgets/async_value_widget.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/star_rating.dart';
import '../../models/rating.dart';
import '../../providers/ratings_provider.dart';

class UserRatingsScreen extends ConsumerWidget {
  const UserRatingsScreen({super.key, required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(userRatingSummaryProvider(userId));
    final ratingsAsync = ref.watch(userRatingsProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Reputation')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userRatingSummaryProvider(userId));
          ref.invalidate(userRatingsProvider(userId));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            summaryAsync.when(
              data: (summary) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(summary.averageStars.toStringAsFixed(1), style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 4),
                      StarRatingDisplay(stars: summary.averageStars, size: 22),
                      const SizedBox(height: 4),
                      Text('${summary.totalRatings} rating${summary.totalRatings == 1 ? '' : 's'}'),
                    ],
                  ),
                ),
              ),
              loading: () => const SizedBox(height: 140, child: Center(child: CircularProgressIndicator())),
              error: (e, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
            AsyncValueWidget<List<Rating>>(
              value: ratingsAsync,
              onRetry: () => ref.invalidate(userRatingsProvider(userId)),
              data: (ratings) {
                if (ratings.isEmpty) {
                  return const EmptyState(icon: Icons.star_border, message: 'No reviews yet.');
                }
                return Column(
                  children: ratings
                      .map((r) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(r.ratedBy.name, style: Theme.of(context).textTheme.titleSmall),
                                      StarRatingDisplay(stars: r.stars.toDouble()),
                                    ],
                                  ),
                                  if (r.review != null && r.review!.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(r.review!),
                                  ],
                                  if (r.createdAt != null) ...[
                                    const SizedBox(height: 6),
                                    Text(
                                      DateFormat.yMMMd().format(r.createdAt!),
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
