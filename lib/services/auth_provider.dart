import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_modol.dart';
import '../utilis/constants.dart';
import 'api.dart';
import 'auth_services.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends BaseProvider {
  final AuthService _authService = AuthService(baseUrl: Url);
  final Api _api = Api();
  bool _isAdmin = false;

  bool get isAdmin => _isAdmin;
  UserModel _user =
      UserModel(id: 0, name: '', email: '', telephone: '', roles: '');

  UserModel get user => _user;
  String _errorMessage =
      "Sorry, this email address is already registered in our system"; // Add a private error message variable

  // Define a method to get the error message
  String getMessage() {
    return _errorMessage;
  }

  Future<bool> getUser() async {
    setBusy(true);

    // Check if a token exists
    final bool tokenExists = await getToken();

    if (tokenExists) {
      try {
        // Send a request to get user data from your Laravel API
        final response = await _authService.getUser();

        print('User Info Response Status Code: ${response.statusCode}');
        print('User Info Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);

          // Optionally, you can parse and store user data here if needed
          // Example: final User user = User.fromJson(data['user']);

          // Await the saveToken function to save the token
          await saveToken(
              data['access_token']); // Use 'access_token' instead of 'token'

          setBusy(false);
          return true; // User is authenticated
        } else {
          // Handle the case where the user information request failed
          // You might want to clear the token or perform other actions
          // depending on your app's requirements.
          setBusy(false);
          return false;
        }
      } catch (e) {
        // Handle exceptions, such as network errors
        print("Error getting user info: $e");
        setBusy(false);
        return false;
      }
    } else {
      // No token exists, meaning the user is not logged in
      setBusy(false);
      return false;
    }
  }

  Future<bool> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      _api.token = token;
      print(token);
      return true;
    }
    return false;
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<bool> login(String? email, String? password) async {
    setBusy(true);
    try {
      // Check if email and password are not null before proceeding
      if (email == null || password == null) {
        print('Email or password is null');
        setMessage("Please provide both email and password.");
        setBusy(false);
        return false; // Return false for invalid input
      }

      // Replace this with your actual authentication logic.
      final bool userExists = await authenticateUserOnServer(email, password);

      if (userExists) {
        print('Login Successful');
        setBusy(false);
        return true; // User exists in the database
      } else {
        print('Login Failed');
        setMessage("Invalid email or password.");
        setBusy(false);
        return false; // User does not exist in the database or invalid credentials
      }
    } catch (e) {
      print("Error during login: $e");
      setMessage("An error occurred during login. Please try again later.");
      setBusy(false);
      return false; // Return false for any error
    }
  }

  Future<bool> authenticateUserOnServer(String email, String password) async {
    try {
      // Make an API request to verify the user's credentials
      final response = await _authService.login(email, password);

      // Check if the response is JSON
      if (response.headers['content-type']?.startsWith('application/json') ??
          false) {
        var res = jsonDecode(response.body.toString());
        print("this is $res");
        print("this is it  ${res["token"]}");

        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Check if 'user' key exists in the response and is not null
        if (res["user"] != null) {
          // Check if 'roles' key exists in 'user' and is not null
          if (res["user"]["roles"] != null) {
            prefs.setString("roles", res["user"]["roles"]);
          }
        }

        if (response.statusCode == 200) {
          // Successful authentication
          return true;
        } else {
          // Authentication failed
          return false;
        }
      } else {
        print('Response is not JSON. Actual response: ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle any exceptions or errors that occur during the authentication process
      print("Error during authentication: $e");
      return false;
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    _api.token = token;
  }

  Future<bool> register(
      String name, String email, String password, String telephone) async {
    final url = Uri.parse('$Url/api/register');

    try {
      final response = await http.post(
        url,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'telephone': telephone, // Add telephone here
        },
      );

      // Print the status code and the response body
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration was successful
        print('Registration successful');
        return true; // Return true for a successful registration
      } else {
        // Registration failed
        _errorMessage =
            response.body; // Store the error message from the server
        return false; // Return false for a failed registration
      }
    } catch (e) {
      // Handle network errors or other exceptions
      print('Error during registration: $e');
      _errorMessage =
          e.toString(); // Store the error message from the exception
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      // Implement any additional logout logic if needed
    } on SocketException {
      // Handle network errors during logout
    } catch (e) {
      // Handle other exceptions during logout
    }
  }

  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final List<UserModel> users = await _authService.searchUsers(query);
      return users;
    } catch (e) {
      throw Exception('Error searching for users: $e');
    }
  }

  Future<bool> resetPassword(
      String email, String password, String passwordConfirmation) async {
    final url = Uri.parse('$Url/api/resetPassword');

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Password reset successful');
        return true;
      } else {
        print('User not found');
        return false;
      }
    } catch (e) {
      print('Error during password reset: $e');
      return false;
    }
  }
}
