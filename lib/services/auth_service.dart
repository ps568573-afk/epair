import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final data = await ApiService.post('/auth/login', {
      'email': email,
      'password': password,
    });
    // Save token and user
    await ApiService.saveToken(data['token']);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('epair_user', jsonEncode(data['user']));
    return data;
  }

  // Register
  static Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    final data = await ApiService.post('/auth/register', userData);
    await ApiService.saveToken(data['token']);
    return data;
  }

  // Logout
  static Future<void> logout() async {
    await ApiService.clearToken();
  }

  // Get stored user
  static Future<Map<String, dynamic>?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('epair_user');
    if (user != null) return jsonDecode(user);
    return null;
  }

  // Check if logged in
  static Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null;
  }
}