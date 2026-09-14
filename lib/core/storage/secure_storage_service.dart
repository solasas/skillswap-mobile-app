import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wraps flutter_secure_storage for persisting the JWT and light user info.
/// There is no refresh-token endpoint on the backend, so once the token
/// expires (jwt.expiration, default 24h) the only recourse is to clear
/// storage and route back to login.
class SecureStorageService {
  SecureStorageService._internal();
  static final SecureStorageService instance = SecureStorageService._internal();

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';
  static const _userNameKey = 'user_name';
  static const _userEmailKey = 'user_email';

  Future<void> saveSession({
    required String token,
    required int userId,
    required String name,
    required String email,
  }) async {
    await Future.wait([
      _storage.write(key: _tokenKey, value: token),
      _storage.write(key: _userIdKey, value: userId.toString()),
      _storage.write(key: _userNameKey, value: name),
      _storage.write(key: _userEmailKey, value: email),
    ]);
  }

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<int?> readUserId() async {
    final raw = await _storage.read(key: _userIdKey);
    return raw == null ? null : int.tryParse(raw);
  }

  Future<String?> readUserName() => _storage.read(key: _userNameKey);

  Future<String?> readUserEmail() => _storage.read(key: _userEmailKey);

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
