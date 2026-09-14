import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../core/utils/enums.dart';
import '../models/skill.dart';

class SkillsRepository {
  SkillsRepository(this._dio);
  final Dio _dio;

  Future<List<Skill>> getSkills({SkillCategory? category}) async {
    try {
      final response = await _dio.get('/skills', queryParameters: {
        if (category != null) 'category': category.wire,
      });
      return (response.data as List)
          .map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get('/skills/categories');
      return (response.data as List).map((e) => e.toString()).toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Skill> getSkill(int id) async {
    try {
      final response = await _dio.get('/skills/$id');
      return Skill.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Skill> createSkill({
    required String name,
    required SkillCategory category,
    String? description,
  }) async {
    try {
      final response = await _dio.post('/skills', data: {
        'name': name,
        'category': category.wire,
        if (description != null) 'description': description,
      });
      return Skill.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
