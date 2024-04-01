import 'dart:convert';

import 'package:coffee/models/user_modol.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utilis/constants.dart';
import 'api.dart';

class AuthService {
  final String baseUrl;

  final Api _api = Api();
  AuthService({required this.baseUrl});

  Future<http.Response> getUser() async {
    final response = await http.get(Uri.parse('$Url/api/user'));
    return response;
  }

  Future<List<UserModel>> searchUsers(String query) async {
    // ignore: unnecessary_null_comparison
    if (query == null) {
      throw Exception('Search query cannot be null.');
    }

    final response = await http.get(Uri.parse('$Url/api/users'));

    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');

      final List<dynamic> data = json.decode(response.body);
      // ignore: unnecessary_type_check
      if (data is List) {
        final List<UserModel> users =
            data.map((user) => UserModel.fromJson(user)).toList();
        return users;
      } else {
        throw Exception('Invalid user data format in the API response.');
      }
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response;
  }

  Future<http.Response> register(
      String name, String email, String password, String telephone) async {
    try {
      final api = Api(); // Create an instance of the Api class
      final response = await api.httpPost('register', {
        'name': name,
        'email': email,
        'password': password,
        'telephone': telephone,
      });
      return response;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<bool> isUserAdmin() async {
    try {
      final response = await _api.authenticatedRequest('api/checkAdmin');
      final Map<String, dynamic> data = jsonDecode(response.body);
      final bool isAdmin = data['is_admin'] ??
          false; // Adjust the key according to your API response
      return isAdmin;
    } catch (e) {
      print('Error checking admin status: $e');
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
