import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/session.dart';
import 'core_providers.dart';

final mySessionsProvider = FutureProvider.autoDispose<List<Session>>((ref) {
  return ref.watch(sessionsRepositoryProvider).getMySessions();
});

final sessionDetailProvider =
    FutureProvider.autoDispose.family<Session, int>((ref, id) {
  return ref.watch(sessionsRepositoryProvider).getById(id);
});

final exchangeSessionsProvider =
    FutureProvider.autoDispose.family<List<Session>, int>((ref, exchangeId) {
  return ref.watch(sessionsRepositoryProvider).getForExchange(exchangeId);
});
