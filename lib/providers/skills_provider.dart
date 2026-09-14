import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/enums.dart';
import '../models/skill.dart';
import 'core_providers.dart';

final allSkillsProvider = FutureProvider.autoDispose<List<Skill>>((ref) {
  return ref.watch(skillsRepositoryProvider).getSkills();
});

final skillsByCategoryProvider =
    FutureProvider.autoDispose.family<List<Skill>, SkillCategory?>((ref, category) {
  return ref.watch(skillsRepositoryProvider).getSkills(category: category);
});
