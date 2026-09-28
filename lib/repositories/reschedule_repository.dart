import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../models/reschedule_request.dart';
import '../models/session.dart';

class RescheduleRepository {
  RescheduleRepository(this._dio);
  final Dio _dio;

  Future<RescheduleRequest> proposeReschedule({
    required int sessionId,
    required DateTime proposedDateTime,
    String? reason,
  }) async {
    try {
      final response = await _dio.post(
        '/sessions/$sessionId/reschedule',
        data: {
          'proposedDateTime': _formatLocalDateTime(proposedDateTime),
          if (reason != null && reason.isNotEmpty) 'reason': reason,
        },
      );
      return RescheduleRequest.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<RescheduleRequest>> getRescheduleRequests(int sessionId) async {
    try {
      final response = await _dio.get('/sessions/$sessionId/reschedule-requests');
      return (response.data as List)
          .map((e) => RescheduleRequest.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Session> acceptReschedule({
    required int sessionId,
    required int requestId,
  }) async {
    try {
      final response = await _dio.put(
        '/sessions/$sessionId/reschedule-requests/$requestId/accept',
      );
      return Session.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<RescheduleRequest> rejectReschedule({
    required int sessionId,
    required int requestId,
  }) async {
    try {
      final response = await _dio.put(
        '/sessions/$sessionId/reschedule-requests/$requestId/reject',
      );
      return RescheduleRequest.fromJson(response.data as Map<String, dynamic>);
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
