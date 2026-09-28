// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      otherUser: User.fromJson(json['otherUser'] as Map<String, dynamic>),
      lastMessage: Message.fromJson(
        json['lastMessage'] as Map<String, dynamic>,
      ),
      unreadCount: (json['unreadCount'] as num).toInt(),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'otherUser': instance.otherUser,
      'lastMessage': instance.lastMessage,
      'unreadCount': instance.unreadCount,
    };
