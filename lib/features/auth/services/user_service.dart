import 'dart:convert';
import 'package:http/http.dart' as http;

import 'storage_service.dart';

class UserService {

  static const String baseUrl =
      'http://192.168.0.191:3000/api';
  // =========================
  // GET CURRENT USER
  // =========================
  static Future<Map<String, dynamic>> getCurrentUser() async {

    try {

      // GET SAVED JWT TOKEN
      final token = await StorageService.getToken();

      // NO TOKEN FOUND
      if (token == null) {


        return {
          "success": false,
          "message": "No token found",
        };
      }

      final response = await http.get(
        Uri.parse('$baseUrl/users/me'),

        headers: {
          'Content-Type': 'application/json',

          // SEND JWT TOKEN
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      // SUCCESS
      if (response.statusCode == 200) {

        return {
          "success": true,
          "data": data['data'],
        };

      } else {

        return {
          "success": false,
          "message": data['message'],
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