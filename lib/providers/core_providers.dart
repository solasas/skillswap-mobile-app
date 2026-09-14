import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/network/dio_client.dart';
import '../repositories/auth_repository.dart';
import '../repositories/exchanges_repository.dart';
import '../repositories/matches_repository.dart';
import '../repositories/profile_repository.dart';
import '../repositories/ratings_repository.dart';
import '../repositories/sessions_repository.dart';
import '../repositories/skills_repository.dart';
import 'auth_provider.dart';

/// The shared Dio instance. Its 401 hook forces the auth provider back to
/// the logged-out state, which the router picks up to redirect to /login.
final dioProvider = Provider<Dio>((ref) {
  final client = DioClient(
    onUnauthorized: () => ref.read(authProvider.notifier).forceLogout(),
  );
  return client.dio;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(dioProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(dioProvider));
});

final skillsRepositoryProvider = Provider<SkillsRepository>((ref) {
  return SkillsRepository(ref.watch(dioProvider));
});

final matchesRepositoryProvider = Provider<MatchesRepository>((ref) {
  return MatchesRepository(ref.watch(dioProvider));
});

final exchangesRepositoryProvider = Provider<ExchangesRepository>((ref) {
  return ExchangesRepository(ref.watch(dioProvider));
});

final sessionsRepositoryProvider = Provider<SessionsRepository>((ref) {
  return SessionsRepository(ref.watch(dioProvider));
});

final ratingsRepositoryProvider = Provider<RatingsRepository>((ref) {
  return RatingsRepository(ref.watch(dioProvider));
});
