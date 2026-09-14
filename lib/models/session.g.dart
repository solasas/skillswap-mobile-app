// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      id: (json['id'] as num).toInt(),
      exchange: SkillExchange.fromJson(
        json['exchange'] as Map<String, dynamic>,
      ),
      scheduledBy: User.fromJson(json['scheduledBy'] as Map<String, dynamic>),
      dateTime: DateTime.parse(json['dateTime'] as String),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      mode: sessionModeFromJson(json['mode'] as String?),
      meetLink: json['meetLink'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      status: sessionStatusFromJson(json['status'] as String?),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exchange': instance.exchange,
      'scheduledBy': instance.scheduledBy,
      'dateTime': instance.dateTime.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'mode': sessionModeToJson(instance.mode),
      'meetLink': instance.meetLink,
      'location': instance.location,
      'notes': instance.notes,
      'status': sessionStatusToJson(instance.status),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
