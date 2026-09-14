import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/skill_exchange.dart';
import 'core_providers.dart';

final sentExchangesProvider = FutureProvider.autoDispose<List<SkillExchange>>((ref) {
  return ref.watch(exchangesRepositoryProvider).getSent();
});

final receivedExchangesProvider = FutureProvider.autoDispose<List<SkillExchange>>((ref) {
  return ref.watch(exchangesRepositoryProvider).getReceived();
});

final exchangeDetailProvider =
    FutureProvider.autoDispose.family<SkillExchange, int>((ref, id) {
  return ref.watch(exchangesRepositoryProvider).getById(id);
});

/// Call after accept/reject/complete/create so inbox and detail screens
/// refetch fresh data.
void invalidateExchanges(WidgetRef ref) {
  ref.invalidate(sentExchangesProvider);
  ref.invalidate(receivedExchangesProvider);
}
