import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SessionManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getUserId() async => await _storage.read(key: 'id');

  Future<void> setUserId(String id) async =>
      await _storage.write(key: 'id', value: id);

  Future<String?> getToken() async => await _storage.read(key: 'token');

  Future<void> setToken(String token) async =>
      await _storage.write(key: 'token', value: token);

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
  }
}
