import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../core/utils/enums.dart';
import '../models/session.dart';

class SessionsRepository {
  SessionsRepository(this._dio);
  final Dio _dio;

  Future<Session> createSession({
    required int exchangeId,
    required DateTime dateTime,
    required int durationMinutes,
    required SessionMode mode,
    String? meetLink,
    String? location,
    String? notes,
  }) async {
    try {
      final response = await _dio.post('/exchanges/$exchangeId/sessions', data: {
        'dateTime': _formatLocalDateTime(dateTime),
        'durationMinutes': durationMinutes,
        'mode': mode.wire,
        if (meetLink != null && meetLink.isNotEmpty) 'meetLink': meetLink,
        if (location != null && location.isNotEmpty) 'location': location,
        if (notes != null && notes.isNotEmpty) 'notes': notes,
      });
      return Session.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Session>> getForExchange(int exchangeId) async {
    try {
      final response = await _dio.get('/exchanges/$exchangeId/sessions');
      return (response.data as List)
          .map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Session>> getMySessions() async {
    try {
      final response = await _dio.get('/sessions/my-sessions');
      return (response.data as List)
          .map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Session> getById(int id) async {
    try {
      final response = await _dio.get('/sessions/$id');
      return Session.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Session> complete(int id) async {
    try {
      final response = await _dio.put('/sessions/$id/complete');
      return Session.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Session> cancel(int id) async {
    try {
      final response = await _dio.put('/sessions/$id/cancel');
      return Session.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Formats as ISO-8601 LocalDateTime without a trailing 'Z'/offset, e.g.
  /// "2024-01-15T10:30:00", matching what Jackson expects for a Java
  /// LocalDateTime field.
  static String _formatLocalDateTime(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)}T${two(dt.hour)}:${two(dt.minute)}:${two(dt.second)}';
  }
}
