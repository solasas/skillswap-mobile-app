/// Central place for backend connection settings.
///
/// The Spring Boot backend's CORS config only allows localhost:3000/8080,
/// which does not matter for mobile (emulator/device) or desktop builds
/// since CORS is a browser-only restriction. For a Flutter *web* build,
/// ask the backend dev to add your dev origin to CORS, or run through a
/// proxy.
class ApiConstants {
  ApiConstants._();

  /// Android emulators reach the host machine's localhost via 10.0.2.2.
  /// iOS simulators and desktop can use localhost directly.
  /// Override at build time with:
  ///   flutter run --dart-define=API_BASE_URL=http://192.168.1.23:8080/api
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api',
  );

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
