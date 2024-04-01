import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utilis/constants.dart';

class Api {
  static final Api _api = Api._internal(
    baseUrl: Url,
    path: 'api/',
    token: '', 
  );

  factory Api() {
    return _api;
  }

  Api._internal({
    required this.baseUrl,
    required this.path,
    required this.token,
  });

  String token;
  String baseUrl;
  String path;

  // Set the authentication token
  void setToken(String newToken) {
    token = newToken;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print("Token: $token"); // Add this line for debugging
    if (token != null) {
      this.token =
          token; // Assuming 'this.token' is the token property in the Api class
      return token;
    }
    return null;
  }

  Future<http.Response> authenticatedRequest(String endPath,
      {Map<String, String>? query}) async {
    String? token = await getToken();
    if (token != null) {
      Uri uri = Uri.parse('$baseUrl/$path/$endPath');
      final response = await http.get(
        uri,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token', // Add the token here
        },
      );

      if (response.statusCode == 200) {
        // Successful response
        return response;
      } else {
        // Handle other status codes as needed
        if (response.headers['content-type']
                ?.toLowerCase()
                .contains('application/json') ??
            false) {
          // It's JSON, try to parse it
          try {
            final Map<String, dynamic> errorData = jsonDecode(response.body);
            final String errorMessage = errorData['message'] ?? 'Unknown error';
            return http.Response(errorMessage, response.statusCode);
          } catch (e) {
            // Unable to parse JSON, return the original response
            return response;
          }
        } else {
          // Content type is not JSON, return the original response
          return response;
        }
      }
    } else {
      // No token available
      return http.Response('Access token not available', 401);
    }
  }

  Future<http.Response> httpGet(String endPath,
      {Map<String, String>? query}) async {
    Uri uri = Uri.parse('$baseUrl/$path/$endPath');
    return await http.get(
      uri,
      headers: {
        'accept': 'application/json',
        'authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> httpPost(String endPath, Object body) async {
    Uri uri = Uri.parse('$baseUrl/$path/$endPath');
    return await http.post(
      uri,
      headers: {
        'accept': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: body.toString(), // Convert the body to a string if needed
    );
  }
}
