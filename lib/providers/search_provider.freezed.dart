// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserSearchFilters {
  String? get skillName => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  SkillLevel? get level => throw _privateConstructorUsedError;
  double? get minRating => throw _privateConstructorUsedError;
  bool? get availableOnly => throw _privateConstructorUsedError;

  /// Create a copy of UserSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSearchFiltersCopyWith<UserSearchFilters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSearchFiltersCopyWith<$Res> {
  factory $UserSearchFiltersCopyWith(
    UserSearchFilters value,
    $Res Function(UserSearchFilters) then,
  ) = _$UserSearchFiltersCopyWithImpl<$Res, UserSearchFilters>;
  @useResult
  $Res call({
    String? skillName,
    String? city,
    SkillLevel? level,
    double? minRating,
    bool? availableOnly,
  });
}

/// @nodoc
class _$UserSearchFiltersCopyWithImpl<$Res, $Val extends UserSearchFilters>
    implements $UserSearchFiltersCopyWith<$Res> {
  _$UserSearchFiltersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillName = freezed,
    Object? city = freezed,
    Object? level = freezed,
    Object? minRating = freezed,
    Object? availableOnly = freezed,
  }) {
    return _then(
      _value.copyWith(
            skillName: freezed == skillName
                ? _value.skillName
                : skillName // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            level: freezed == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as SkillLevel?,
            minRating: freezed == minRating
                ? _value.minRating
                : minRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            availableOnly: freezed == availableOnly
                ? _value.availableOnly
                : availableOnly // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSearchFiltersImplCopyWith<$Res>
    implements $UserSearchFiltersCopyWith<$Res> {
  factory _$$UserSearchFiltersImplCopyWith(
    _$UserSearchFiltersImpl value,
    $Res Function(_$UserSearchFiltersImpl) then,
  ) = __$$UserSearchFiltersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? skillName,
    String? city,
    SkillLevel? level,
    double? minRating,
    bool? availableOnly,
  });
}

/// @nodoc
class __$$UserSearchFiltersImplCopyWithImpl<$Res>
    extends _$UserSearchFiltersCopyWithImpl<$Res, _$UserSearchFiltersImpl>
    implements _$$UserSearchFiltersImplCopyWith<$Res> {
  __$$UserSearchFiltersImplCopyWithImpl(
    _$UserSearchFiltersImpl _value,
    $Res Function(_$UserSearchFiltersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillName = freezed,
    Object? city = freezed,
    Object? level = freezed,
    Object? minRating = freezed,
    Object? availableOnly = freezed,
  }) {
    return _then(
      _$UserSearchFiltersImpl(
        skillName: freezed == skillName
            ? _value.skillName
            : skillName // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        level: freezed == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as SkillLevel?,
        minRating: freezed == minRating
            ? _value.minRating
            : minRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        availableOnly: freezed == availableOnly
            ? _value.availableOnly
            : availableOnly // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$UserSearchFiltersImpl implements _UserSearchFilters {
  const _$UserSearchFiltersImpl({
    this.skillName,
    this.city,
    this.level,
    this.minRating,
    this.availableOnly,
  });

  @override
  final String? skillName;
  @override
  final String? city;
  @override
  final SkillLevel? level;
  @override
  final double? minRating;
  @override
  final bool? availableOnly;

  @override
  String toString() {
    return 'UserSearchFilters(skillName: $skillName, city: $city, level: $level, minRating: $minRating, availableOnly: $availableOnly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSearchFiltersImpl &&
            (identical(other.skillName, skillName) ||
                other.skillName == skillName) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.minRating, minRating) ||
                other.minRating == minRating) &&
            (identical(other.availableOnly, availableOnly) ||
                other.availableOnly == availableOnly));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    skillName,
    city,
    level,
    minRating,
    availableOnly,
  );

  /// Create a copy of UserSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSearchFiltersImplCopyWith<_$UserSearchFiltersImpl> get copyWith =>
      __$$UserSearchFiltersImplCopyWithImpl<_$UserSearchFiltersImpl>(
        this,
        _$identity,
      );
}

abstract class _UserSearchFilters implements UserSearchFilters {
  const factory _UserSearchFilters({
    final String? skillName,
    final String? city,
    final SkillLevel? level,
    final double? minRating,
    final bool? availableOnly,
  }) = _$UserSearchFiltersImpl;

  @override
  String? get skillName;
  @override
  String? get city;
  @override
  SkillLevel? get level;
  @override
  double? get minRating;
  @override
  bool? get availableOnly;

  /// Create a copy of UserSearchFilters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSearchFiltersImplCopyWith<_$UserSearchFiltersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
