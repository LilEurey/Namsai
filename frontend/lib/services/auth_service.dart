// 📁 lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:3000/api/users/login';

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('userId', data['user']['_id']);
        await prefs.setString('userEmail', data['user']['email']);
        await prefs.setString('userRole', data['user']['role']);

        return {'success': true, 'role': data['user']['role']};
      } else {
        return {'success': false, 'message': data['error'] ?? 'Login failed'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred. Please try again.',
      };
    }
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
  }

  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String tel,
  }) async {
    final url = Uri.parse('http://localhost:3000/api/users/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'tel': tel,
        }),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'user': json['user']};
      } else {
        return {'success': false, 'error': json['error'] ?? 'Unknown error'};
      }
    } catch (e) {
      return {'success': false, 'error': '❌ Failed to connect: $e'};
    }
  }
}
