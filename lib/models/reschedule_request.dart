import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/utils/enums.dart';
import 'user.dart';

part 'reschedule_request.freezed.dart';
part 'reschedule_request.g.dart';

@freezed
class RescheduleRequest with _$RescheduleRequest {
  const factory RescheduleRequest({
    required int id,
    required int sessionId,
    required User requestedBy,
    required DateTime proposedDateTime,
    String? reason,
    @JsonKey(fromJson: rescheduleStatusFromJson, toJson: rescheduleStatusToJson)
    required RescheduleStatus status,
    DateTime? createdAt,
  }) = _RescheduleRequest;

  factory RescheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$RescheduleRequestFromJson(json);
}
