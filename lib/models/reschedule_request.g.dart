// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reschedule_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RescheduleRequestImpl _$$RescheduleRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RescheduleRequestImpl(
  id: (json['id'] as num).toInt(),
  sessionId: (json['sessionId'] as num).toInt(),
  requestedBy: User.fromJson(json['requestedBy'] as Map<String, dynamic>),
  proposedDateTime: DateTime.parse(json['proposedDateTime'] as String),
  reason: json['reason'] as String?,
  status: rescheduleStatusFromJson(json['status'] as String?),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$RescheduleRequestImplToJson(
  _$RescheduleRequestImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sessionId': instance.sessionId,
  'requestedBy': instance.requestedBy,
  'proposedDateTime': instance.proposedDateTime.toIso8601String(),
  'reason': instance.reason,
  'status': rescheduleStatusToJson(instance.status),
  'createdAt': instance.createdAt?.toIso8601String(),
};
