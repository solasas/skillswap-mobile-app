import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/availability.dart';
import 'core_providers.dart';

final myAvailabilityProvider = FutureProvider.autoDispose<List<Availability>>((ref) {
  return ref.watch(availabilityRepositoryProvider).getMyAvailability();
});

final userAvailabilityProvider =
    FutureProvider.autoDispose.family<List<Availability>, int>((ref, userId) {
  return ref.watch(availabilityRepositoryProvider).getUserAvailability(userId);
});
