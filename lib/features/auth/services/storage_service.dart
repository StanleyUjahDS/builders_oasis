import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {

  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  // =========================
  // SAVE JWT TOKEN
  // =========================
  static Future<void> saveToken(String token) async {

    await _storage.write(
      key: 'jwt_token',
      value: token,
    );
  }

  // =========================
  // GET JWT TOKEN
  // =========================
  static Future<String?> getToken() async {

    return await _storage.read(
      key: 'jwt_token',
    );
  }

  // =========================
  // SAVE USER DATA
  // =========================
  static Future<void> saveUser(
      Map<String, dynamic> user,
      ) async {

    await _storage.write(
      key: 'user',
      value: jsonEncode(user),
    );
  }

  // =========================
  // GET USER DATA
  // =========================
  static Future<Map<String, dynamic>?> getUser() async {

    final user = await _storage.read(
      key: 'user',
    );

    if (user == null) {
      return null;
    }

    return jsonDecode(user);
  }

  // =========================
  // CHECK LOGIN STATUS
  // =========================
  static Future<bool> isLoggedIn() async {

    final token = await getToken();

    return token != null;
  }

  // =========================
  // CLEAR USER ONLY
  // =========================
  static Future<void> clearUser() async {

    await _storage.delete(
      key: 'user',
    );
  }

  // =========================
  // CLEAR TOKEN ONLY
  // =========================
  static Future<void> clearToken() async {

    await _storage.delete(
      key: 'jwt_token',
    );
  }

  // =========================
  // CLEAR ALL STORAGE
  // =========================
  static Future<void> clearStorage() async {

    await _storage.deleteAll();
  }

  // =========================
  // LOGOUT USER
  // =========================
  static Future<void> logout() async {

    await clearStorage();
  }
}