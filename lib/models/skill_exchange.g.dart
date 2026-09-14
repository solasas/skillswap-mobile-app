// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillExchangeImpl _$$SkillExchangeImplFromJson(Map<String, dynamic> json) =>
    _$SkillExchangeImpl(
      id: (json['id'] as num).toInt(),
      requester: User.fromJson(json['requester'] as Map<String, dynamic>),
      receiver: User.fromJson(json['receiver'] as Map<String, dynamic>),
      offeredSkill: Skill.fromJson(
        json['offeredSkill'] as Map<String, dynamic>,
      ),
      wantedSkill: Skill.fromJson(json['wantedSkill'] as Map<String, dynamic>),
      status: exchangeStatusFromJson(json['status'] as String?),
      message: json['message'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SkillExchangeImplToJson(_$SkillExchangeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requester': instance.requester,
      'receiver': instance.receiver,
      'offeredSkill': instance.offeredSkill,
      'wantedSkill': instance.wantedSkill,
      'status': exchangeStatusToJson(instance.status),
      'message': instance.message,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
