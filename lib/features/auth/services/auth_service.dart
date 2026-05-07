import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  static const String baseUrl =
      'http://192.168.0.82:3000/api/auth';

  /// REGISTER
  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {

    try {

      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "first_name": firstName.trim(),
          "last_name": lastName.trim(),
          "email": email.toLowerCase().trim(),
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        return {
          "success": true,
          "data": data,
        };

      } else {

        return {
          "success": false,
          "message":
          data['message'] ?? 'Registration failed',
        };
      }

    } catch (e) {

      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  /// LOGIN
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {

    try {

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email.toLowerCase().trim(),
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return {
          "success": true,
          "data": data,
        };

      } else {

        return {
          "success": false,
          "message":
          data['message'] ?? 'Login failed',
        };
      }

    } catch (e) {

      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}