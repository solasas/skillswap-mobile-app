// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RatingImpl _$$RatingImplFromJson(Map<String, dynamic> json) => _$RatingImpl(
  id: (json['id'] as num).toInt(),
  session: json['session'] == null
      ? null
      : Session.fromJson(json['session'] as Map<String, dynamic>),
  ratedBy: User.fromJson(json['ratedBy'] as Map<String, dynamic>),
  ratedTo: User.fromJson(json['ratedTo'] as Map<String, dynamic>),
  stars: (json['stars'] as num).toInt(),
  review: json['review'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$RatingImplToJson(_$RatingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'session': instance.session,
      'ratedBy': instance.ratedBy,
      'ratedTo': instance.ratedTo,
      'stars': instance.stars,
      'review': instance.review,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
