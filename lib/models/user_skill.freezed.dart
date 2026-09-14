// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_skill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSkill _$UserSkillFromJson(Map<String, dynamic> json) {
  return _UserSkill.fromJson(json);
}

/// @nodoc
mixin _$UserSkill {
  int get id => throw _privateConstructorUsedError;
  Skill get skill => throw _privateConstructorUsedError;
  @JsonKey(fromJson: skillTypeFromJson, toJson: skillTypeToJson)
  SkillType get type => throw _privateConstructorUsedError;
  @JsonKey(fromJson: skillLevelFromJson, toJson: skillLevelToJson)
  SkillLevel get level => throw _privateConstructorUsedError;

  /// Serializes this UserSkill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSkill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSkillCopyWith<UserSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSkillCopyWith<$Res> {
  factory $UserSkillCopyWith(UserSkill value, $Res Function(UserSkill) then) =
      _$UserSkillCopyWithImpl<$Res, UserSkill>;
  @useResult
  $Res call({
    int id,
    Skill skill,
    @JsonKey(fromJson: skillTypeFromJson, toJson: skillTypeToJson)
    SkillType type,
    @JsonKey(fromJson: skillLevelFromJson, toJson: skillLevelToJson)
    SkillLevel level,
  });

  $SkillCopyWith<$Res> get skill;
}

/// @nodoc
class _$UserSkillCopyWithImpl<$Res, $Val extends UserSkill>
    implements $UserSkillCopyWith<$Res> {
  _$UserSkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSkill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? skill = null,
    Object? type = null,
    Object? level = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            skill: null == skill
                ? _value.skill
                : skill // ignore: cast_nullable_to_non_nullable
                      as Skill,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SkillType,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as SkillLevel,
          )
          as $Val,
    );
  }

  /// Create a copy of UserSkill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get skill {
    return $SkillCopyWith<$Res>(_value.skill, (value) {
      return _then(_value.copyWith(skill: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserSkillImplCopyWith<$Res>
    implements $UserSkillCopyWith<$Res> {
  factory _$$UserSkillImplCopyWith(
    _$UserSkillImpl value,
    $Res Function(_$UserSkillImpl) then,
  ) = __$$UserSkillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    Skill skill,
    @JsonKey(fromJson: skillTypeFromJson, toJson: skillTypeToJson)
    SkillType type,
    @JsonKey(fromJson: skillLevelFromJson, toJson: skillLevelToJson)
    SkillLevel level,
  });

  @override
  $SkillCopyWith<$Res> get skill;
}

/// @nodoc
class __$$UserSkillImplCopyWithImpl<$Res>
    extends _$UserSkillCopyWithImpl<$Res, _$UserSkillImpl>
    implements _$$UserSkillImplCopyWith<$Res> {
  __$$UserSkillImplCopyWithImpl(
    _$UserSkillImpl _value,
    $Res Function(_$UserSkillImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSkill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? skill = null,
    Object? type = null,
    Object? level = null,
  }) {
    return _then(
      _$UserSkillImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        skill: null == skill
            ? _value.skill
            : skill // ignore: cast_nullable_to_non_nullable
                  as Skill,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SkillType,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as SkillLevel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSkillImpl implements _UserSkill {
  const _$UserSkillImpl({
    required this.id,
    required this.skill,
    @JsonKey(fromJson: skillTypeFromJson, toJson: skillTypeToJson)
    required this.type,
    @JsonKey(fromJson: skillLevelFromJson, toJson: skillLevelToJson)
    required this.level,
  });

  factory _$UserSkillImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSkillImplFromJson(json);

  @override
  final int id;
  @override
  final Skill skill;
  @override
  @JsonKey(fromJson: skillTypeFromJson, toJson: skillTypeToJson)
  final SkillType type;
  @override
  @JsonKey(fromJson: skillLevelFromJson, toJson: skillLevelToJson)
  final SkillLevel level;

  @override
  String toString() {
    return 'UserSkill(id: $id, skill: $skill, type: $type, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSkillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.skill, skill) || other.skill == skill) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, skill, type, level);

  /// Create a copy of UserSkill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSkillImplCopyWith<_$UserSkillImpl> get copyWith =>
      __$$UserSkillImplCopyWithImpl<_$UserSkillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSkillImplToJson(this);
  }
}

abstract class _UserSkill implements UserSkill {
  const factory _UserSkill({
    required final int id,
    required final Skill skill,
    @JsonKey(fromJson: skillTypeFromJson, toJson: skillTypeToJson)
    required final SkillType type,
    @JsonKey(fromJson: skillLevelFromJson, toJson: skillLevelToJson)
    required final SkillLevel level,
  }) = _$UserSkillImpl;

  factory _UserSkill.fromJson(Map<String, dynamic> json) =
      _$UserSkillImpl.fromJson;

  @override
  int get id;
  @override
  Skill get skill;
  @override
  @JsonKey(fromJson: skillTypeFromJson, toJson: skillTypeToJson)
  SkillType get type;
  @override
  @JsonKey(fromJson: skillLevelFromJson, toJson: skillLevelToJson)
  SkillLevel get level;

  /// Create a copy of UserSkill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSkillImplCopyWith<_$UserSkillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
