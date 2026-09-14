// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/utils/enums.dart';
import 'skill.dart';

part 'user_skill.freezed.dart';
part 'user_skill.g.dart';

@freezed
class UserSkill with _$UserSkill {
  const factory UserSkill({
    required int id,
    required Skill skill,
    @JsonKey(fromJson: skillTypeFromJson, toJson: skillTypeToJson)
    required SkillType type,
    @JsonKey(fromJson: skillLevelFromJson, toJson: skillLevelToJson)
    required SkillLevel level,
  }) = _UserSkill;

  factory UserSkill.fromJson(Map<String, dynamic> json) => _$UserSkillFromJson(json);
}
