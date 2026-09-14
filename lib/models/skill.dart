// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/utils/enums.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    required int id,
    required String name,
    @JsonKey(fromJson: skillCategoryFromJson, toJson: skillCategoryToJson)
    required SkillCategory category,
    String? description,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
