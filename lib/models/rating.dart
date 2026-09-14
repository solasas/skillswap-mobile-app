import 'package:freezed_annotation/freezed_annotation.dart';

import 'session.dart';
import 'user.dart';

part 'rating.freezed.dart';
part 'rating.g.dart';

@freezed
class Rating with _$Rating {
  const factory Rating({
    required int id,
    Session? session,
    required User ratedBy,
    required User ratedTo,
    required int stars,
    String? review,
    DateTime? createdAt,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}

@freezed
class RatingSummary with _$RatingSummary {
  const factory RatingSummary({
    @Default(0) int totalRatings,
    @Default(0.0) double averageStars,
  }) = _RatingSummary;

  // Manual fromJson (instead of the generated _$RatingSummaryFromJson) since
  // the backend's exact field names for this aggregate aren't documented in
  // the API spec provided — this tries the common naming variants.
  factory RatingSummary.fromJson(Map<String, dynamic> json) {
    final total = json['totalRatings'] ?? json['count'] ?? json['ratingCount'] ?? 0;
    final avg = json['averageStars'] ??
        json['averageRating'] ??
        json['average'] ??
        0.0;
    return RatingSummary(
      totalRatings: total is num ? total.toInt() : int.tryParse('$total') ?? 0,
      averageStars: avg is num ? avg.toDouble() : double.tryParse('$avg') ?? 0.0,
    );
  }
}
