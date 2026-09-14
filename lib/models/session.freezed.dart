// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Session _$SessionFromJson(Map<String, dynamic> json) {
  return _Session.fromJson(json);
}

/// @nodoc
mixin _$Session {
  int get id => throw _privateConstructorUsedError;
  SkillExchange get exchange => throw _privateConstructorUsedError;
  User get scheduledBy => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(fromJson: sessionModeFromJson, toJson: sessionModeToJson)
  SessionMode get mode => throw _privateConstructorUsedError;
  String? get meetLink => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(fromJson: sessionStatusFromJson, toJson: sessionStatusToJson)
  SessionStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call({
    int id,
    SkillExchange exchange,
    User scheduledBy,
    DateTime dateTime,
    int durationMinutes,
    @JsonKey(fromJson: sessionModeFromJson, toJson: sessionModeToJson)
    SessionMode mode,
    String? meetLink,
    String? location,
    String? notes,
    @JsonKey(fromJson: sessionStatusFromJson, toJson: sessionStatusToJson)
    SessionStatus status,
    DateTime? createdAt,
  });

  $SkillExchangeCopyWith<$Res> get exchange;
  $UserCopyWith<$Res> get scheduledBy;
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exchange = null,
    Object? scheduledBy = null,
    Object? dateTime = null,
    Object? durationMinutes = null,
    Object? mode = null,
    Object? meetLink = freezed,
    Object? location = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            exchange: null == exchange
                ? _value.exchange
                : exchange // ignore: cast_nullable_to_non_nullable
                      as SkillExchange,
            scheduledBy: null == scheduledBy
                ? _value.scheduledBy
                : scheduledBy // ignore: cast_nullable_to_non_nullable
                      as User,
            dateTime: null == dateTime
                ? _value.dateTime
                : dateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as SessionMode,
            meetLink: freezed == meetLink
                ? _value.meetLink
                : meetLink // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as SessionStatus,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SkillExchangeCopyWith<$Res> get exchange {
    return $SkillExchangeCopyWith<$Res>(_value.exchange, (value) {
      return _then(_value.copyWith(exchange: value) as $Val);
    });
  }

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get scheduledBy {
    return $UserCopyWith<$Res>(_value.scheduledBy, (value) {
      return _then(_value.copyWith(scheduledBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
    _$SessionImpl value,
    $Res Function(_$SessionImpl) then,
  ) = __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    SkillExchange exchange,
    User scheduledBy,
    DateTime dateTime,
    int durationMinutes,
    @JsonKey(fromJson: sessionModeFromJson, toJson: sessionModeToJson)
    SessionMode mode,
    String? meetLink,
    String? location,
    String? notes,
    @JsonKey(fromJson: sessionStatusFromJson, toJson: sessionStatusToJson)
    SessionStatus status,
    DateTime? createdAt,
  });

  @override
  $SkillExchangeCopyWith<$Res> get exchange;
  @override
  $UserCopyWith<$Res> get scheduledBy;
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
    _$SessionImpl _value,
    $Res Function(_$SessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exchange = null,
    Object? scheduledBy = null,
    Object? dateTime = null,
    Object? durationMinutes = null,
    Object? mode = null,
    Object? meetLink = freezed,
    Object? location = freezed,
    Object? notes = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        exchange: null == exchange
            ? _value.exchange
            : exchange // ignore: cast_nullable_to_non_nullable
                  as SkillExchange,
        scheduledBy: null == scheduledBy
            ? _value.scheduledBy
            : scheduledBy // ignore: cast_nullable_to_non_nullable
                  as User,
        dateTime: null == dateTime
            ? _value.dateTime
            : dateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as SessionMode,
        meetLink: freezed == meetLink
            ? _value.meetLink
            : meetLink // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SessionStatus,
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
class _$SessionImpl implements _Session {
  const _$SessionImpl({
    required this.id,
    required this.exchange,
    required this.scheduledBy,
    required this.dateTime,
    required this.durationMinutes,
    @JsonKey(fromJson: sessionModeFromJson, toJson: sessionModeToJson)
    required this.mode,
    this.meetLink,
    this.location,
    this.notes,
    @JsonKey(fromJson: sessionStatusFromJson, toJson: sessionStatusToJson)
    required this.status,
    this.createdAt,
  });

  factory _$SessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionImplFromJson(json);

  @override
  final int id;
  @override
  final SkillExchange exchange;
  @override
  final User scheduledBy;
  @override
  final DateTime dateTime;
  @override
  final int durationMinutes;
  @override
  @JsonKey(fromJson: sessionModeFromJson, toJson: sessionModeToJson)
  final SessionMode mode;
  @override
  final String? meetLink;
  @override
  final String? location;
  @override
  final String? notes;
  @override
  @JsonKey(fromJson: sessionStatusFromJson, toJson: sessionStatusToJson)
  final SessionStatus status;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Session(id: $id, exchange: $exchange, scheduledBy: $scheduledBy, dateTime: $dateTime, durationMinutes: $durationMinutes, mode: $mode, meetLink: $meetLink, location: $location, notes: $notes, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exchange, exchange) ||
                other.exchange == exchange) &&
            (identical(other.scheduledBy, scheduledBy) ||
                other.scheduledBy == scheduledBy) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.meetLink, meetLink) ||
                other.meetLink == meetLink) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    exchange,
    scheduledBy,
    dateTime,
    durationMinutes,
    mode,
    meetLink,
    location,
    notes,
    status,
    createdAt,
  );

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionImplToJson(this);
  }
}

abstract class _Session implements Session {
  const factory _Session({
    required final int id,
    required final SkillExchange exchange,
    required final User scheduledBy,
    required final DateTime dateTime,
    required final int durationMinutes,
    @JsonKey(fromJson: sessionModeFromJson, toJson: sessionModeToJson)
    required final SessionMode mode,
    final String? meetLink,
    final String? location,
    final String? notes,
    @JsonKey(fromJson: sessionStatusFromJson, toJson: sessionStatusToJson)
    required final SessionStatus status,
    final DateTime? createdAt,
  }) = _$SessionImpl;

  factory _Session.fromJson(Map<String, dynamic> json) = _$SessionImpl.fromJson;

  @override
  int get id;
  @override
  SkillExchange get exchange;
  @override
  User get scheduledBy;
  @override
  DateTime get dateTime;
  @override
  int get durationMinutes;
  @override
  @JsonKey(fromJson: sessionModeFromJson, toJson: sessionModeToJson)
  SessionMode get mode;
  @override
  String? get meetLink;
  @override
  String? get location;
  @override
  String? get notes;
  @override
  @JsonKey(fromJson: sessionStatusFromJson, toJson: sessionStatusToJson)
  SessionStatus get status;
  @override
  DateTime? get createdAt;

  /// Create a copy of Session
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
