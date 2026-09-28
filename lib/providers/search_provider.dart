import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/enums.dart';
import '../models/user.dart';
import 'core_providers.dart';

part 'search_provider.freezed.dart';

@freezed
class UserSearchFilters with _$UserSearchFilters {
  const factory UserSearchFilters({
    String? skillName,
    String? city,
    SkillLevel? level,
    double? minRating,
    bool? availableOnly,
  }) = _UserSearchFilters;
}

final userSearchFiltersProvider = StateProvider<UserSearchFilters>((ref) {
  return const UserSearchFilters();
});

final userSearchResultsProvider = FutureProvider.autoDispose<List<User>>((ref) {
  final filters = ref.watch(userSearchFiltersProvider);
  return ref.watch(usersRepositoryProvider).search(
    skillName: filters.skillName,
    city: filters.city,
    level: filters.level,
    minRating: filters.minRating,
    availableOnly: filters.availableOnly,
  );
});
