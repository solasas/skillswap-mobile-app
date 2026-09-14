import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../models/rating.dart';

class RatingsRepository {
  RatingsRepository(this._dio);
  final Dio _dio;

  Future<Rating> rateSession({
    required int sessionId,
    required int stars,
    String? review,
  }) async {
    assert(stars >= 1 && stars <= 5, 'stars must be between 1 and 5');
    try {
      final response = await _dio.post('/sessions/$sessionId/ratings', data: {
        'stars': stars,
        if (review != null && review.isNotEmpty) 'review': review,
      });
      return Rating.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Rating>> getUserRatings(int userId) async {
    try {
      final response = await _dio.get('/users/$userId/ratings');
      return (response.data as List)
          .map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<RatingSummary> getUserRatingSummary(int userId) async {
    try {
      final response = await _dio.get('/users/$userId/rating-summary');
      return RatingSummary.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
