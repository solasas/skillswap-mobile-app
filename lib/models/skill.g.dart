// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  category: skillCategoryFromJson(json['category'] as String?),
  description: json['description'] as String?,
);

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': skillCategoryToJson(instance.category),
      'description': instance.description,
    };
