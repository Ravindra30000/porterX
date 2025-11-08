import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "https://porterx.onrender.com/api/auth";
  static const String baseUrl1 = "https://porterx.onrender.com/api/protected";
  static const String baseUrl2 = "https://porterx.onrender.com/api/passenger";//
  // 🛑 Emulator ke liye
  // static const String baseUrl = "http://192.168.xx.xx:5000/api/auth"; // 🛑 Real Device ke liye (IP change karo)



  // 🔹 Get User Profile API
  static Future<Map<String, dynamic>> getUserProfile(String token) async {
    if (token.isEmpty) {
      return {"success": false, "message": "User not logged in!"};
    }

    final url = Uri.parse("$baseUrl1/profile");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "$token", // ✅ FIXED: Bearer token
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Failed to fetch profile!"};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }
//function to call passenger data submit
  static Future<Map<String, dynamic>> submitPassengerData({
    required String userId,
    required String name,
    required int age,
    required String mobileNumber,
    required String trainno,
    required String trainCoach,
    required String seatNumber,
    required double totalBagWeight,
    int? trolleyBags,
    int? otherBags,
  }) async {
    final url = Uri.parse('$baseUrl2/submit');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'name': name,
          'age': age,
          'mobileNumber': mobileNumber,
          'trainNo': trainno,
          'trainCoach': trainCoach,
          'seatNumber': seatNumber,
          'totalBagWeight': totalBagWeight,
          'trolleyBags': trolleyBags ?? 0,
          'otherBags': otherBags ?? 0,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {"success": true, "message": data['message'] ?? "Passenger data saved successfully"};
      } else {
        return {"success": false, "message": data['message'] ?? "Something went wrong"};
      }
    } catch (e) {
      return {"success": false, "message": "Exception occurred: $e"};
    }
  }


// 🔹 Login or Register with Mobile Number
  static Future<Map<String, dynamic>> loginWithMobile(String mobileNumber) async {
    final url = Uri.parse("https://porterx.onrender.com/api/user/login"); // Replace with your local IP

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mobileNumber": mobileNumber}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Optionally save userId or token using SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', data['userId']);

        return {"success": true, "userId": data['userId']};
      } else {
        final data = jsonDecode(response.body);
        return {"success": false, "message": data['message']};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }
  static Future<Map<String, dynamic>> submitBooking({
    required String userId,
    required String station,
    required DateTime dateOfBooking,
    required int passengers,
  }) async {
    final url = Uri.parse("https://porterx.onrender.com/api/booking/create"); // Replace with your IP

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'station': station,
          'dateOfBooking': dateOfBooking.toIso8601String(),
          'passengers': passengers,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {"success": true, "bookingId": data['bookingId']};
      } else {
        return {"success": false, "message": data['message']};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }

  }

