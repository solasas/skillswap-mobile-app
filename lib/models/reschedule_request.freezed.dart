// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reschedule_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RescheduleRequest _$RescheduleRequestFromJson(Map<String, dynamic> json) {
  return _RescheduleRequest.fromJson(json);
}

/// @nodoc
mixin _$RescheduleRequest {
  int get id => throw _privateConstructorUsedError;
  int get sessionId => throw _privateConstructorUsedError;
  User get requestedBy => throw _privateConstructorUsedError;
  DateTime get proposedDateTime => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  @JsonKey(fromJson: rescheduleStatusFromJson, toJson: rescheduleStatusToJson)
  RescheduleStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this RescheduleRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RescheduleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RescheduleRequestCopyWith<RescheduleRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RescheduleRequestCopyWith<$Res> {
  factory $RescheduleRequestCopyWith(
    RescheduleRequest value,
    $Res Function(RescheduleRequest) then,
  ) = _$RescheduleRequestCopyWithImpl<$Res, RescheduleRequest>;
  @useResult
  $Res call({
    int id,
    int sessionId,
    User requestedBy,
    DateTime proposedDateTime,
    String? reason,
    @JsonKey(fromJson: rescheduleStatusFromJson, toJson: rescheduleStatusToJson)
    RescheduleStatus status,
    DateTime? createdAt,
  });

  $UserCopyWith<$Res> get requestedBy;
}

/// @nodoc
class _$RescheduleRequestCopyWithImpl<$Res, $Val extends RescheduleRequest>
    implements $RescheduleRequestCopyWith<$Res> {
  _$RescheduleRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RescheduleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? requestedBy = null,
    Object? proposedDateTime = null,
    Object? reason = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as int,
            requestedBy: null == requestedBy
                ? _value.requestedBy
                : requestedBy // ignore: cast_nullable_to_non_nullable
                      as User,
            proposedDateTime: null == proposedDateTime
                ? _value.proposedDateTime
                : proposedDateTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RescheduleStatus,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of RescheduleRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get requestedBy {
    return $UserCopyWith<$Res>(_value.requestedBy, (value) {
      return _then(_value.copyWith(requestedBy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RescheduleRequestImplCopyWith<$Res>
    implements $RescheduleRequestCopyWith<$Res> {
  factory _$$RescheduleRequestImplCopyWith(
    _$RescheduleRequestImpl value,
    $Res Function(_$RescheduleRequestImpl) then,
  ) = __$$RescheduleRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int sessionId,
    User requestedBy,
    DateTime proposedDateTime,
    String? reason,
    @JsonKey(fromJson: rescheduleStatusFromJson, toJson: rescheduleStatusToJson)
    RescheduleStatus status,
    DateTime? createdAt,
  });

  @override
  $UserCopyWith<$Res> get requestedBy;
}

/// @nodoc
class __$$RescheduleRequestImplCopyWithImpl<$Res>
    extends _$RescheduleRequestCopyWithImpl<$Res, _$RescheduleRequestImpl>
    implements _$$RescheduleRequestImplCopyWith<$Res> {
  __$$RescheduleRequestImplCopyWithImpl(
    _$RescheduleRequestImpl _value,
    $Res Function(_$RescheduleRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RescheduleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sessionId = null,
    Object? requestedBy = null,
    Object? proposedDateTime = null,
    Object? reason = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$RescheduleRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as int,
        requestedBy: null == requestedBy
            ? _value.requestedBy
            : requestedBy // ignore: cast_nullable_to_non_nullable
                  as User,
        proposedDateTime: null == proposedDateTime
            ? _value.proposedDateTime
            : proposedDateTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RescheduleStatus,
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
class _$RescheduleRequestImpl implements _RescheduleRequest {
  const _$RescheduleRequestImpl({
    required this.id,
    required this.sessionId,
    required this.requestedBy,
    required this.proposedDateTime,
    this.reason,
    @JsonKey(fromJson: rescheduleStatusFromJson, toJson: rescheduleStatusToJson)
    required this.status,
    this.createdAt,
  });

  factory _$RescheduleRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RescheduleRequestImplFromJson(json);

  @override
  final int id;
  @override
  final int sessionId;
  @override
  final User requestedBy;
  @override
  final DateTime proposedDateTime;
  @override
  final String? reason;
  @override
  @JsonKey(fromJson: rescheduleStatusFromJson, toJson: rescheduleStatusToJson)
  final RescheduleStatus status;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'RescheduleRequest(id: $id, sessionId: $sessionId, requestedBy: $requestedBy, proposedDateTime: $proposedDateTime, reason: $reason, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RescheduleRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.requestedBy, requestedBy) ||
                other.requestedBy == requestedBy) &&
            (identical(other.proposedDateTime, proposedDateTime) ||
                other.proposedDateTime == proposedDateTime) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sessionId,
    requestedBy,
    proposedDateTime,
    reason,
    status,
    createdAt,
  );

  /// Create a copy of RescheduleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RescheduleRequestImplCopyWith<_$RescheduleRequestImpl> get copyWith =>
      __$$RescheduleRequestImplCopyWithImpl<_$RescheduleRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RescheduleRequestImplToJson(this);
  }
}

abstract class _RescheduleRequest implements RescheduleRequest {
  const factory _RescheduleRequest({
    required final int id,
    required final int sessionId,
    required final User requestedBy,
    required final DateTime proposedDateTime,
    final String? reason,
    @JsonKey(fromJson: rescheduleStatusFromJson, toJson: rescheduleStatusToJson)
    required final RescheduleStatus status,
    final DateTime? createdAt,
  }) = _$RescheduleRequestImpl;

  factory _RescheduleRequest.fromJson(Map<String, dynamic> json) =
      _$RescheduleRequestImpl.fromJson;

  @override
  int get id;
  @override
  int get sessionId;
  @override
  User get requestedBy;
  @override
  DateTime get proposedDateTime;
  @override
  String? get reason;
  @override
  @JsonKey(fromJson: rescheduleStatusFromJson, toJson: rescheduleStatusToJson)
  RescheduleStatus get status;
  @override
  DateTime? get createdAt;

  /// Create a copy of RescheduleRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RescheduleRequestImplCopyWith<_$RescheduleRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
