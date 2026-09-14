import 'package:dio/dio.dart';

/// Uniform error shape returned by the backend: { message, timestamp, status }
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final DateTime? timestamp;

  ApiException({required this.message, this.statusCode, this.timestamp});

  factory ApiException.fromDioException(DioException e) {
    final response = e.response;
    if (response != null && response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;
      final msg = data['message'] as String?;
      DateTime? ts;
      final tsRaw = data['timestamp'];
      if (tsRaw is String) {
        ts = DateTime.tryParse(tsRaw);
      }
      return ApiException(
        message: msg ?? _fallbackMessage(e),
        statusCode: response.statusCode,
        timestamp: ts,
      );
    }
    return ApiException(
      message: _fallbackMessage(e),
      statusCode: response?.statusCode,
    );
  }

  static String _fallbackMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'Could not connect to the server. Check your connection.';
      case DioExceptionType.badResponse:
        return 'Something went wrong (${e.response?.statusCode ?? 'unknown'}).';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      default:
        return e.message ?? 'An unexpected error occurred.';
    }
  }

  bool get isUnauthorized => statusCode == 401;
  bool get isForbidden => statusCode == 403;
  bool get isNotFound => statusCode == 404;

  @override
  String toString() => message;
}
