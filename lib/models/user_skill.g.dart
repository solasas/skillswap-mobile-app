// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSkillImpl _$$UserSkillImplFromJson(Map<String, dynamic> json) =>
    _$UserSkillImpl(
      id: (json['id'] as num).toInt(),
      skill: Skill.fromJson(json['skill'] as Map<String, dynamic>),
      type: skillTypeFromJson(json['type'] as String?),
      level: skillLevelFromJson(json['level'] as String?),
    );

Map<String, dynamic> _$$UserSkillImplToJson(_$UserSkillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'skill': instance.skill,
      'type': skillTypeToJson(instance.type),
      'level': skillLevelToJson(instance.level),
    };
