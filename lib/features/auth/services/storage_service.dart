import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {

  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  /// SAVE JWT TOKEN
  static Future<void> saveToken(String token) async {

    await _storage.write(
      key: 'jwt_token',
      value: token,
    );
  }

  /// GET JWT TOKEN
  static Future<String?> getToken() async {

    return await _storage.read(
      key: 'jwt_token',
    );
  }

  /// SAVE USER DATA
  static Future<void> saveUser(
      Map<String, dynamic> user,
      ) async {

    await _storage.write(
      key: 'user',
      value: jsonEncode(user),
    );
  }

  /// GET USER DATA
  static Future<Map<String, dynamic>?> getUser() async {

    final user = await _storage.read(
      key: 'user',
    );

    if (user == null) {
      return null;
    }

    return jsonDecode(user);
  }

  /// CHECK IF USER IS LOGGED IN
  static Future<bool> isLoggedIn() async {

    final token = await getToken();

    return token != null;
  }

  /// LOGOUT USER
  static Future<void> logout() async {

    await _storage.deleteAll();
  }
}