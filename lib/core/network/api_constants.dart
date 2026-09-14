import 'platform_default_host.dart';

/// Central place for backend connection settings.
///
/// The Spring Boot backend's CORS config only allows localhost:3000/8080,
/// which does not matter for mobile (emulator/device) or desktop builds
/// since CORS is a browser-only restriction. For a Flutter *web* build,
/// ask the backend dev to add your dev origin to CORS, or run through a
/// proxy.
class ApiConstants {
  ApiConstants._();

  /// Defaults to `localhost` everywhere except the Android emulator, whose
  /// virtual NIC requires `10.0.2.2` to reach the host machine.
  /// Override at build time for a physical device on your LAN, e.g.:
  ///   flutter run --dart-define=API_BASE_URL=http://192.168.1.23:8080/api
  static final String baseUrl = const String.fromEnvironment('API_BASE_URL').isNotEmpty
      ? const String.fromEnvironment('API_BASE_URL')
      : 'http://$platformDefaultHost:8080/api';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
