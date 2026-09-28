import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required int id,
    required User sender,
    required User receiver,
    required String content,
    required bool read,
    required DateTime createdAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
