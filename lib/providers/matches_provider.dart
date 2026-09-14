import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/match_result.dart';
import 'core_providers.dart';

final allMatchesProvider = FutureProvider.autoDispose<List<MatchResult>>((ref) {
  return ref.watch(matchesRepositoryProvider).getAllMatches();
});

final mutualMatchesProvider = FutureProvider.autoDispose<List<MatchResult>>((ref) {
  return ref.watch(matchesRepositoryProvider).getMutualMatches();
});

final matchDetailProvider =
    FutureProvider.autoDispose.family<MatchResult, int>((ref, userId) {
  return ref.watch(matchesRepositoryProvider).getMatchDetail(userId);
});
