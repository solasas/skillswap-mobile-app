// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/utils/enums.dart';
import 'skill.dart';
import 'user.dart';

part 'skill_exchange.freezed.dart';
part 'skill_exchange.g.dart';

@freezed
class SkillExchange with _$SkillExchange {
  const factory SkillExchange({
    required int id,
    required User requester,
    required User receiver,
    required Skill offeredSkill,
    required Skill wantedSkill,
    @JsonKey(fromJson: exchangeStatusFromJson, toJson: exchangeStatusToJson)
    required ExchangeStatus status,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SkillExchange;

  factory SkillExchange.fromJson(Map<String, dynamic> json) =>
      _$SkillExchangeFromJson(json);
}
