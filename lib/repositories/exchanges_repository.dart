import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../models/skill_exchange.dart';

class ExchangesRepository {
  ExchangesRepository(this._dio);
  final Dio _dio;

  Future<SkillExchange> createExchange({
    required int receiverId,
    required int offeredSkillId,
    required int wantedSkillId,
    String? message,
  }) async {
    try {
      final response = await _dio.post('/exchanges', data: {
        'receiverId': receiverId,
        'offeredSkillId': offeredSkillId,
        'wantedSkillId': wantedSkillId,
        if (message != null && message.isNotEmpty) 'message': message,
      });
      return SkillExchange.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<SkillExchange>> getAll() async {
    try {
      final response = await _dio.get('/exchanges');
      return (response.data as List)
          .map((e) => SkillExchange.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<SkillExchange>> getSent() async {
    try {
      final response = await _dio.get('/exchanges/sent');
      return (response.data as List)
          .map((e) => SkillExchange.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<SkillExchange>> getReceived() async {
    try {
      final response = await _dio.get('/exchanges/received');
      return (response.data as List)
          .map((e) => SkillExchange.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<SkillExchange> getById(int id) async {
    try {
      final response = await _dio.get('/exchanges/$id');
      return SkillExchange.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<SkillExchange> accept(int id) async {
    try {
      final response = await _dio.put('/exchanges/$id/accept');
      return SkillExchange.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<SkillExchange> reject(int id) async {
    try {
      final response = await _dio.put('/exchanges/$id/reject');
      return SkillExchange.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<SkillExchange> complete(int id) async {
    try {
      final response = await _dio.put('/exchanges/$id/complete');
      return SkillExchange.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
