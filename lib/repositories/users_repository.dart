import 'package:dio/dio.dart';

import '../core/network/api_exception.dart';
import '../core/utils/enums.dart';
import '../models/user.dart';

class UsersRepository {
  UsersRepository(this._dio);
  final Dio _dio;

  Future<List<User>> search({
    String? skillName,
    String? city,
    SkillLevel? level,
    double? minRating,
    bool? availableOnly,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (skillName != null && skillName.isNotEmpty) {
        queryParams['skillName'] = skillName;
      }
      if (city != null && city.isNotEmpty) {
        queryParams['city'] = city;
      }
      if (level != null) {
        queryParams['level'] = level.wire;
      }
      if (minRating != null) {
        queryParams['minRating'] = minRating;
      }
      if (availableOnly != null) {
        queryParams['availableOnly'] = availableOnly;
      }

      final response = await _dio.get(
        '/users/search',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      return (response.data as List)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
