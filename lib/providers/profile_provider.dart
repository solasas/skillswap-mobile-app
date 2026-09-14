import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/rating.dart';
import '../models/user.dart';
import '../models/user_skill.dart';
import 'core_providers.dart';

final myProfileProvider = FutureProvider.autoDispose<User>((ref) {
  return ref.watch(profileRepositoryProvider).getMe();
});

final mySkillsProvider = FutureProvider.autoDispose<List<UserSkill>>((ref) {
  return ref.watch(profileRepositoryProvider).getMySkills();
});

final myRatingsProvider = FutureProvider.autoDispose<List<Rating>>((ref) {
  return ref.watch(profileRepositoryProvider).getMyRatings();
});
