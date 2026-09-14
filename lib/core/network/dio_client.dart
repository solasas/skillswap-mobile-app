import 'package:dio/dio.dart';

import '../storage/secure_storage_service.dart';
import 'api_constants.dart';

/// Fired whenever a request comes back 401 (expired/invalid token).
/// The router listens to this to force a redirect to /login.
typedef UnauthorizedCallback = void Function();

class DioClient {
  DioClient({this._onUnauthorized}) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        contentType: 'application/json',
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageService.instance.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            await SecureStorageService.instance.clear();
            _onUnauthorized?.call();
          }
          handler.next(error);
        },
      ),
    );
  }

  late final Dio dio;
  final UnauthorizedCallback? _onUnauthorized;
}
