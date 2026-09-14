// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return _Rating.fromJson(json);
}

/// @nodoc
mixin _$Rating {
  int get id => throw _privateConstructorUsedError;
  Session? get session => throw _privateConstructorUsedError;
  User get ratedBy => throw _privateConstructorUsedError;
  User get ratedTo => throw _privateConstructorUsedError;
  int get stars => throw _privateConstructorUsedError;
  String? get review => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Rating to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingCopyWith<Rating> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingCopyWith<$Res> {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) then) =
      _$RatingCopyWithImpl<$Res, Rating>;
  @useResult
  $Res call({
    int id,
    Session? session,
    User ratedBy,
    User ratedTo,
    int stars,
    String? review,
    DateTime? createdAt,
  });

  $SessionCopyWith<$Res>? get session;
  $UserCopyWith<$Res> get ratedBy;
  $UserCopyWith<$Res> get ratedTo;
}

/// @nodoc
class _$RatingCopyWithImpl<$Res, $Val extends Rating>
    implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? session = freezed,
    Object? ratedBy = null,
    Object? ratedTo = null,
    Object? stars = null,
    Object? review = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            session: freezed == session
                ? _value.session
                : session // ignore: cast_nullable_to_non_nullable
                      as Session?,
            ratedBy: null == ratedBy
                ? _value.ratedBy
                : ratedBy // ignore: cast_nullable_to_non_nullable
                      as User,
            ratedTo: null == ratedTo
                ? _value.ratedTo
                : ratedTo // ignore: cast_nullable_to_non_nullable
                      as User,
            stars: null == stars
                ? _value.stars
                : stars // ignore: cast_nullable_to_non_nullable
                      as int,
            review: freezed == review
                ? _value.review
                : review // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionCopyWith<$Res>? get session {
    if (_value.session == null) {
      return null;
    }

    return $SessionCopyWith<$Res>(_value.session!, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get ratedBy {
    return $UserCopyWith<$Res>(_value.ratedBy, (value) {
      return _then(_value.copyWith(ratedBy: value) as $Val);
    });
  }

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get ratedTo {
    return $UserCopyWith<$Res>(_value.ratedTo, (value) {
      return _then(_value.copyWith(ratedTo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RatingImplCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$$RatingImplCopyWith(
    _$RatingImpl value,
    $Res Function(_$RatingImpl) then,
  ) = __$$RatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    Session? session,
    User ratedBy,
    User ratedTo,
    int stars,
    String? review,
    DateTime? createdAt,
  });

  @override
  $SessionCopyWith<$Res>? get session;
  @override
  $UserCopyWith<$Res> get ratedBy;
  @override
  $UserCopyWith<$Res> get ratedTo;
}

/// @nodoc
class __$$RatingImplCopyWithImpl<$Res>
    extends _$RatingCopyWithImpl<$Res, _$RatingImpl>
    implements _$$RatingImplCopyWith<$Res> {
  __$$RatingImplCopyWithImpl(
    _$RatingImpl _value,
    $Res Function(_$RatingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? session = freezed,
    Object? ratedBy = null,
    Object? ratedTo = null,
    Object? stars = null,
    Object? review = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$RatingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        session: freezed == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                  as Session?,
        ratedBy: null == ratedBy
            ? _value.ratedBy
            : ratedBy // ignore: cast_nullable_to_non_nullable
                  as User,
        ratedTo: null == ratedTo
            ? _value.ratedTo
            : ratedTo // ignore: cast_nullable_to_non_nullable
                  as User,
        stars: null == stars
            ? _value.stars
            : stars // ignore: cast_nullable_to_non_nullable
                  as int,
        review: freezed == review
            ? _value.review
            : review // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingImpl implements _Rating {
  const _$RatingImpl({
    required this.id,
    this.session,
    required this.ratedBy,
    required this.ratedTo,
    required this.stars,
    this.review,
    this.createdAt,
  });

  factory _$RatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingImplFromJson(json);

  @override
  final int id;
  @override
  final Session? session;
  @override
  final User ratedBy;
  @override
  final User ratedTo;
  @override
  final int stars;
  @override
  final String? review;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Rating(id: $id, session: $session, ratedBy: $ratedBy, ratedTo: $ratedTo, stars: $stars, review: $review, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.ratedBy, ratedBy) || other.ratedBy == ratedBy) &&
            (identical(other.ratedTo, ratedTo) || other.ratedTo == ratedTo) &&
            (identical(other.stars, stars) || other.stars == stars) &&
            (identical(other.review, review) || other.review == review) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    session,
    ratedBy,
    ratedTo,
    stars,
    review,
    createdAt,
  );

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      __$$RatingImplCopyWithImpl<_$RatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingImplToJson(this);
  }
}

abstract class _Rating implements Rating {
  const factory _Rating({
    required final int id,
    final Session? session,
    required final User ratedBy,
    required final User ratedTo,
    required final int stars,
    final String? review,
    final DateTime? createdAt,
  }) = _$RatingImpl;

  factory _Rating.fromJson(Map<String, dynamic> json) = _$RatingImpl.fromJson;

  @override
  int get id;
  @override
  Session? get session;
  @override
  User get ratedBy;
  @override
  User get ratedTo;
  @override
  int get stars;
  @override
  String? get review;
  @override
  DateTime? get createdAt;

  /// Create a copy of Rating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingImplCopyWith<_$RatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RatingSummary {
  int get totalRatings => throw _privateConstructorUsedError;
  double get averageStars => throw _privateConstructorUsedError;

  /// Create a copy of RatingSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingSummaryCopyWith<RatingSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingSummaryCopyWith<$Res> {
  factory $RatingSummaryCopyWith(
    RatingSummary value,
    $Res Function(RatingSummary) then,
  ) = _$RatingSummaryCopyWithImpl<$Res, RatingSummary>;
  @useResult
  $Res call({int totalRatings, double averageStars});
}

/// @nodoc
class _$RatingSummaryCopyWithImpl<$Res, $Val extends RatingSummary>
    implements $RatingSummaryCopyWith<$Res> {
  _$RatingSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? totalRatings = null, Object? averageStars = null}) {
    return _then(
      _value.copyWith(
            totalRatings: null == totalRatings
                ? _value.totalRatings
                : totalRatings // ignore: cast_nullable_to_non_nullable
                      as int,
            averageStars: null == averageStars
                ? _value.averageStars
                : averageStars // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RatingSummaryImplCopyWith<$Res>
    implements $RatingSummaryCopyWith<$Res> {
  factory _$$RatingSummaryImplCopyWith(
    _$RatingSummaryImpl value,
    $Res Function(_$RatingSummaryImpl) then,
  ) = __$$RatingSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalRatings, double averageStars});
}

/// @nodoc
class __$$RatingSummaryImplCopyWithImpl<$Res>
    extends _$RatingSummaryCopyWithImpl<$Res, _$RatingSummaryImpl>
    implements _$$RatingSummaryImplCopyWith<$Res> {
  __$$RatingSummaryImplCopyWithImpl(
    _$RatingSummaryImpl _value,
    $Res Function(_$RatingSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? totalRatings = null, Object? averageStars = null}) {
    return _then(
      _$RatingSummaryImpl(
        totalRatings: null == totalRatings
            ? _value.totalRatings
            : totalRatings // ignore: cast_nullable_to_non_nullable
                  as int,
        averageStars: null == averageStars
            ? _value.averageStars
            : averageStars // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$RatingSummaryImpl implements _RatingSummary {
  const _$RatingSummaryImpl({this.totalRatings = 0, this.averageStars = 0.0});

  @override
  @JsonKey()
  final int totalRatings;
  @override
  @JsonKey()
  final double averageStars;

  @override
  String toString() {
    return 'RatingSummary(totalRatings: $totalRatings, averageStars: $averageStars)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingSummaryImpl &&
            (identical(other.totalRatings, totalRatings) ||
                other.totalRatings == totalRatings) &&
            (identical(other.averageStars, averageStars) ||
                other.averageStars == averageStars));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalRatings, averageStars);

  /// Create a copy of RatingSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingSummaryImplCopyWith<_$RatingSummaryImpl> get copyWith =>
      __$$RatingSummaryImplCopyWithImpl<_$RatingSummaryImpl>(this, _$identity);
}

abstract class _RatingSummary implements RatingSummary {
  const factory _RatingSummary({
    final int totalRatings,
    final double averageStars,
  }) = _$RatingSummaryImpl;

  @override
  int get totalRatings;
  @override
  double get averageStars;

  /// Create a copy of RatingSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingSummaryImplCopyWith<_$RatingSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
