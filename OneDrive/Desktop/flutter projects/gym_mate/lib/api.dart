// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final String baseUrl = "http://192.168.1.10:3000/auth";

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String gender,
    required String age,
  }) async {
    final url = Uri.parse('http://192.168.1.10:3000/auth/signup');

    final body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
      "confirmationpassword": confirmPassword,
      "phonenumber": phone,
      "gender": gender,
      "age": age,
    });

    print("📤 Sending Signup Data: $body");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("📥 Signup Response status: ${response.statusCode}");
      print("📥 Signup Response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (responseData["successMessage"] == "signup") {
          return null;
        } else {
          return "Signup successful, but response is unexpected.";
        }
      } else if (response.statusCode == 400 &&
          responseData["msg"] == "Email exist") {
        return "This email is already registered.";
      } else {
        return responseData["message"] ?? "Signup failed";
      }
    } catch (error) {
      print("🔥 Signup Error: $error");
      return "An error occurred during signup. Please try again.";
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://192.168.1.10:3000/auth/login');

    final body = jsonEncode({
      "email": email,
      "password": password,
    });

    print("📤 Sending Login Request: $body");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("📥 Login Response status: ${response.statusCode}");
      print("📥 Login Response body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["data"]["token"] != null) {
        String token = responseData["data"]["token"];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        print("✅ Token Saved: $token");

        return null;
      } else {
        print("❌ Login Error: ${responseData["message"]}");
        return responseData["message"] ?? "Login failed";
      }
    } catch (error) {
      print("🔥 Login Error: $error");
      return "An error occurred during login. Please try again.";
    }
  }
}
