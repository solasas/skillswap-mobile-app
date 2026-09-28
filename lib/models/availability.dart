import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/utils/enums.dart';

part 'availability.freezed.dart';
part 'availability.g.dart';

@freezed
class Availability with _$Availability {
  const factory Availability({
    required int id,
    @JsonKey(fromJson: weekDayFromJson, toJson: weekDayToJson)
    required WeekDay dayOfWeek,
    required String startTime,
    required String endTime,
  }) = _Availability;

  factory Availability.fromJson(Map<String, dynamic> json) => _$AvailabilityFromJson(json);
}
