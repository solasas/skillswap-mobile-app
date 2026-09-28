import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../core/utils/enums.dart';
import '../models/rating.dart';
import '../models/user.dart';
import '../models/user_skill.dart';

class ProfileRepository {
  ProfileRepository(this._dio);
  final Dio _dio;

  Future<User> getMe() async {
    try {
      final response = await _dio.get('/profile/me');
      return User.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<User> updateMe({String? name, String? bio, String? city}) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (bio != null) body['bio'] = bio;
      if (city != null) body['city'] = city;
      final response = await _dio.put('/profile/me', data: body);
      return User.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<UserSkill> addSkill({
    required int skillId,
    required SkillType type,
    required SkillLevel level,
  }) async {
    try {
      final response = await _dio.post('/profile/skills', data: {
        'skillId': skillId,
        'type': type.wire,
        'level': level.wire,
      });
      return UserSkill.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<UserSkill>> getMySkills() async {
    try {
      final response = await _dio.get('/profile/skills');
      return (response.data as List)
          .map((e) => UserSkill.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteSkill(int userSkillId) async {
    try {
      await _dio.delete('/profile/skills/$userSkillId');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Rating>> getMyRatings() async {
    try {
      final response = await _dio.get('/profile/me/ratings');
      return (response.data as List)
          .map((e) => Rating.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _dio.put(
        '/profile/me/password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
