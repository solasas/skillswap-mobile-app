// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/utils/enums.dart';
import 'skill_exchange.dart';
import 'user.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required int id,
    required SkillExchange exchange,
    required User scheduledBy,
    required DateTime dateTime,
    required int durationMinutes,
    @JsonKey(fromJson: sessionModeFromJson, toJson: sessionModeToJson)
    required SessionMode mode,
    String? meetLink,
    String? location,
    String? notes,
    @JsonKey(fromJson: sessionStatusFromJson, toJson: sessionStatusToJson)
    required SessionStatus status,
    DateTime? createdAt,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
}
