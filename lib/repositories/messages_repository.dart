import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../models/conversation.dart';
import '../models/message.dart';

class MessagesRepository {
  MessagesRepository(this._dio);
  final Dio _dio;

  Future<Message> sendMessage({
    required int receiverId,
    required String content,
  }) async {
    try {
      final response = await _dio.post(
        '/messages',
        data: {
          'receiverId': receiverId,
          'content': content,
        },
      );
      return Message.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Conversation>> getConversations() async {
    try {
      final response = await _dio.get('/messages/conversations');
      return (response.data as List)
          .map((e) => Conversation.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Message>> getConversation(int otherUserId) async {
    try {
      final response = await _dio.get('/messages/conversations/$otherUserId');
      return (response.data as List)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _dio.get('/messages/unread-count');
      return response.data as int;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
