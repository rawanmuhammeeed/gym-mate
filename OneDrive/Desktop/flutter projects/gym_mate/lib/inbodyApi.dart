import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InBodyApi {
  final String baseUrl = "http://192.168.1.10:3000";

  Future<String?> saveInBodyData({
    required String weight,
    required String length,
    required String age,
    required String gender,
    required String workoutdays,
    required String goal,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/inbodydata/addinbody');

    final body = jsonEncode({
      "weight": int.parse(weight),
      "length": int.parse(length),
      "age": int.parse(age),
      "gender": gender,
      "workoutdays": workoutdays,
      "goal": goal,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      print("📤 Sending InBody Data: $body");
      print("📥 Response status: ${response.statusCode}");
      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        await getInBodyData(forceRefresh: true);
        return null;
      } else {
        final responseData = jsonDecode(response.body);
        print("❌ Unexpected response: ${response.statusCode}");
        return responseData["message"] ?? "Failed to save data.";
      }
    } catch (error) {
      print("🔥 Error: $error");
      return "An error occurred. Please try again.";
    }
  }

  Future<String?> updateInBodyData({
    required String weight,
    required String length,
    required String age,
    required String gender,
    required String workoutdays,
    required String goal,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/inbodydata/updateinbody');

    final body = jsonEncode({
      "weight": int.parse(weight),
      "length": int.parse(length),
      "age": int.parse(age),
      "gender": gender,
      "workoutdays": workoutdays,
      "goal": goal,
    });

    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      print("📝 Updating InBody Data: $body");
      print("📥 Response status: ${response.statusCode}");
      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        await getInBodyData(forceRefresh: true);
        return null;
      } else {
        final responseData = jsonDecode(response.body);
        return responseData["message"] ?? "Failed to update data.";
      }
    } catch (error) {
      print("🔥 Error updating InBody Data: $error");
      return "An error occurred. Please try again.";
    }
  }

  Future<Map<String, dynamic>?> getInBodyData(
      {bool forceRefresh = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print("🔑 Using Token: $token");

    if (!forceRefresh) {
      String? storedData = prefs.getString('inbody_data_$token');
      print("📂 Fetching InBody Data from Local Storage");

      if (storedData != null) {
        final decodedData = jsonDecode(storedData);
        print("📌 Loaded Local InBody Data: $decodedData");
        return decodedData;
      }
    }

    final url = Uri.parse('$baseUrl/inbodydata/getinbody');

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["inbody"] != null) {
          final data = Map<String, dynamic>.from(responseData["inbody"]);
          final dietPlanData = responseData["dietPlan"];

          final combinedData = {
            ...data,
            "dietPlan": dietPlanData ?? {},
          };

          print("📌 Full InBody Data: $combinedData");

          await _saveInBodyLocally(token!, combinedData);
          return combinedData;
        }
      }
      return null;
    } catch (error) {
      print("🔥 Error fetching InBody Data: $error");
      return null;
    }
  }

  Future<void> _saveInBodyLocally(
      String token, Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'inbody_data_$token', jsonEncode(_sanitizeData(data)));

    print("✅ InBody Data Saved Locally for Token: $token");
  }

  Map<String, dynamic> _sanitizeData(Map<String, dynamic> data) {
    return data.map((key, value) {
      if (value is Map) {
        return MapEntry(key, _sanitizeData(Map<String, dynamic>.from(value)));
      } else if (value is List) {
        return MapEntry(
            key,
            value.map((e) {
              if (e is Map) return _sanitizeData(Map<String, dynamic>.from(e));
              return e;
            }).toList());
      } else if (value is DateTime) {
        return MapEntry(key, value.toIso8601String());
      } else {
        return MapEntry(key, value);
      }
    });
  }
}
