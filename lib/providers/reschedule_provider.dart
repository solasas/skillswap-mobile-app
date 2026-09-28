import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/reschedule_request.dart';
import 'core_providers.dart';
import 'sessions_provider.dart';

final sessionRescheduleRequestsProvider =
    FutureProvider.autoDispose.family<List<RescheduleRequest>, int>((ref, sessionId) {
  return ref.watch(rescheduleRepositoryProvider).getRescheduleRequests(sessionId);
});

void invalidateRescheduleProviders(dynamic ref, int sessionId) {
  ref.invalidate(sessionRescheduleRequestsProvider(sessionId));
  ref.invalidate(sessionDetailProvider(sessionId));
  ref.invalidate(mySessionsProvider);
}
