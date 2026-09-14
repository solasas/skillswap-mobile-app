import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/rating.dart';
import 'core_providers.dart';

final userRatingsProvider =
    FutureProvider.autoDispose.family<List<Rating>, int>((ref, userId) {
  return ref.watch(ratingsRepositoryProvider).getUserRatings(userId);
});

final userRatingSummaryProvider =
    FutureProvider.autoDispose.family<RatingSummary, int>((ref, userId) {
  return ref.watch(ratingsRepositoryProvider).getUserRatingSummary(userId);
});
