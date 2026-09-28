import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/network/api_exception.dart';
import '../core/utils/enums.dart';
import '../models/availability.dart';

class AvailabilityRepository {
  AvailabilityRepository(this._dio);
  final Dio _dio;

  Future<Availability> addAvailability({
    required WeekDay dayOfWeek,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
  }) async {
    try {
      final response = await _dio.post(
        '/profile/availability',
        data: {
          'dayOfWeek': dayOfWeek.wire,
          'startTime': '${_pad(startTime.hour)}:${_pad(startTime.minute)}:00',
          'endTime': '${_pad(endTime.hour)}:${_pad(endTime.minute)}:00',
        },
      );
      return Availability.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Availability>> getMyAvailability() async {
    try {
      final response = await _dio.get('/profile/availability');
      return (response.data as List)
          .map((e) => Availability.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<Availability>> getUserAvailability(int userId) async {
    try {
      final response = await _dio.get('/users/$userId/availability');
      return (response.data as List)
          .map((e) => Availability.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> removeAvailability(int id) async {
    try {
      await _dio.delete('/profile/availability/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  static String _pad(int value) => value.toString().padLeft(2, '0');
}
