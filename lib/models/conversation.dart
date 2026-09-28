import 'package:freezed_annotation/freezed_annotation.dart';

import 'message.dart';
import 'user.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required User otherUser,
    required Message lastMessage,
    required int unreadCount,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
