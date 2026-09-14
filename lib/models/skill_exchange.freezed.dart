// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_exchange.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SkillExchange _$SkillExchangeFromJson(Map<String, dynamic> json) {
  return _SkillExchange.fromJson(json);
}

/// @nodoc
mixin _$SkillExchange {
  int get id => throw _privateConstructorUsedError;
  User get requester => throw _privateConstructorUsedError;
  User get receiver => throw _privateConstructorUsedError;
  Skill get offeredSkill => throw _privateConstructorUsedError;
  Skill get wantedSkill => throw _privateConstructorUsedError;
  @JsonKey(fromJson: exchangeStatusFromJson, toJson: exchangeStatusToJson)
  ExchangeStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SkillExchange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkillExchangeCopyWith<SkillExchange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillExchangeCopyWith<$Res> {
  factory $SkillExchangeCopyWith(
    SkillExchange value,
    $Res Function(SkillExchange) then,
  ) = _$SkillExchangeCopyWithImpl<$Res, SkillExchange>;
  @useResult
  $Res call({
    int id,
    User requester,
    User receiver,
    Skill offeredSkill,
    Skill wantedSkill,
    @JsonKey(fromJson: exchangeStatusFromJson, toJson: exchangeStatusToJson)
    ExchangeStatus status,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  $UserCopyWith<$Res> get requester;
  $UserCopyWith<$Res> get receiver;
  $SkillCopyWith<$Res> get offeredSkill;
  $SkillCopyWith<$Res> get wantedSkill;
}

/// @nodoc
class _$SkillExchangeCopyWithImpl<$Res, $Val extends SkillExchange>
    implements $SkillExchangeCopyWith<$Res> {
  _$SkillExchangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requester = null,
    Object? receiver = null,
    Object? offeredSkill = null,
    Object? wantedSkill = null,
    Object? status = null,
    Object? message = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            requester: null == requester
                ? _value.requester
                : requester // ignore: cast_nullable_to_non_nullable
                      as User,
            receiver: null == receiver
                ? _value.receiver
                : receiver // ignore: cast_nullable_to_non_nullable
                      as User,
            offeredSkill: null == offeredSkill
                ? _value.offeredSkill
                : offeredSkill // ignore: cast_nullable_to_non_nullable
                      as Skill,
            wantedSkill: null == wantedSkill
                ? _value.wantedSkill
                : wantedSkill // ignore: cast_nullable_to_non_nullable
                      as Skill,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ExchangeStatus,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get requester {
    return $UserCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get receiver {
    return $UserCopyWith<$Res>(_value.receiver, (value) {
      return _then(_value.copyWith(receiver: value) as $Val);
    });
  }

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get offeredSkill {
    return $SkillCopyWith<$Res>(_value.offeredSkill, (value) {
      return _then(_value.copyWith(offeredSkill: value) as $Val);
    });
  }

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillCopyWith<$Res> get wantedSkill {
    return $SkillCopyWith<$Res>(_value.wantedSkill, (value) {
      return _then(_value.copyWith(wantedSkill: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SkillExchangeImplCopyWith<$Res>
    implements $SkillExchangeCopyWith<$Res> {
  factory _$$SkillExchangeImplCopyWith(
    _$SkillExchangeImpl value,
    $Res Function(_$SkillExchangeImpl) then,
  ) = __$$SkillExchangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    User requester,
    User receiver,
    Skill offeredSkill,
    Skill wantedSkill,
    @JsonKey(fromJson: exchangeStatusFromJson, toJson: exchangeStatusToJson)
    ExchangeStatus status,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  $UserCopyWith<$Res> get requester;
  @override
  $UserCopyWith<$Res> get receiver;
  @override
  $SkillCopyWith<$Res> get offeredSkill;
  @override
  $SkillCopyWith<$Res> get wantedSkill;
}

/// @nodoc
class __$$SkillExchangeImplCopyWithImpl<$Res>
    extends _$SkillExchangeCopyWithImpl<$Res, _$SkillExchangeImpl>
    implements _$$SkillExchangeImplCopyWith<$Res> {
  __$$SkillExchangeImplCopyWithImpl(
    _$SkillExchangeImpl _value,
    $Res Function(_$SkillExchangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requester = null,
    Object? receiver = null,
    Object? offeredSkill = null,
    Object? wantedSkill = null,
    Object? status = null,
    Object? message = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$SkillExchangeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        requester: null == requester
            ? _value.requester
            : requester // ignore: cast_nullable_to_non_nullable
                  as User,
        receiver: null == receiver
            ? _value.receiver
            : receiver // ignore: cast_nullable_to_non_nullable
                  as User,
        offeredSkill: null == offeredSkill
            ? _value.offeredSkill
            : offeredSkill // ignore: cast_nullable_to_non_nullable
                  as Skill,
        wantedSkill: null == wantedSkill
            ? _value.wantedSkill
            : wantedSkill // ignore: cast_nullable_to_non_nullable
                  as Skill,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ExchangeStatus,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillExchangeImpl implements _SkillExchange {
  const _$SkillExchangeImpl({
    required this.id,
    required this.requester,
    required this.receiver,
    required this.offeredSkill,
    required this.wantedSkill,
    @JsonKey(fromJson: exchangeStatusFromJson, toJson: exchangeStatusToJson)
    required this.status,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory _$SkillExchangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillExchangeImplFromJson(json);

  @override
  final int id;
  @override
  final User requester;
  @override
  final User receiver;
  @override
  final Skill offeredSkill;
  @override
  final Skill wantedSkill;
  @override
  @JsonKey(fromJson: exchangeStatusFromJson, toJson: exchangeStatusToJson)
  final ExchangeStatus status;
  @override
  final String? message;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'SkillExchange(id: $id, requester: $requester, receiver: $receiver, offeredSkill: $offeredSkill, wantedSkill: $wantedSkill, status: $status, message: $message, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillExchangeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requester, requester) ||
                other.requester == requester) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.offeredSkill, offeredSkill) ||
                other.offeredSkill == offeredSkill) &&
            (identical(other.wantedSkill, wantedSkill) ||
                other.wantedSkill == wantedSkill) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    requester,
    receiver,
    offeredSkill,
    wantedSkill,
    status,
    message,
    createdAt,
    updatedAt,
  );

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillExchangeImplCopyWith<_$SkillExchangeImpl> get copyWith =>
      __$$SkillExchangeImplCopyWithImpl<_$SkillExchangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillExchangeImplToJson(this);
  }
}

abstract class _SkillExchange implements SkillExchange {
  const factory _SkillExchange({
    required final int id,
    required final User requester,
    required final User receiver,
    required final Skill offeredSkill,
    required final Skill wantedSkill,
    @JsonKey(fromJson: exchangeStatusFromJson, toJson: exchangeStatusToJson)
    required final ExchangeStatus status,
    final String? message,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$SkillExchangeImpl;

  factory _SkillExchange.fromJson(Map<String, dynamic> json) =
      _$SkillExchangeImpl.fromJson;

  @override
  int get id;
  @override
  User get requester;
  @override
  User get receiver;
  @override
  Skill get offeredSkill;
  @override
  Skill get wantedSkill;
  @override
  @JsonKey(fromJson: exchangeStatusFromJson, toJson: exchangeStatusToJson)
  ExchangeStatus get status;
  @override
  String? get message;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of SkillExchange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkillExchangeImplCopyWith<_$SkillExchangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
