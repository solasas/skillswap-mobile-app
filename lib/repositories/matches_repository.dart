import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../models/match_result.dart';

class MatchesRepository {
  MatchesRepository(this._dio);
  final Dio _dio;

  Future<List<MatchResult>> getAllMatches() async {
    try {
      final response = await _dio.get('/matches');
      return (response.data as List)
          .map((e) => MatchResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<MatchResult>> getMutualMatches() async {
    try {
      final response = await _dio.get('/matches/mutual');
      return (response.data as List)
          .map((e) => MatchResult.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<MatchResult> getMatchDetail(int userId) async {
    try {
      final response = await _dio.get('/matches/$userId');
      return MatchResult.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
