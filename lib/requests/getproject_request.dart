import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interiordesign_mobile/Model/project_model.dart';
import 'package:interiordesign_mobile/api.dart';
import 'package:interiordesign_mobile/end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Getallproject {
  static Future<ApiResponse> getallproject(
    BuildContext context,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final authtoken = prefs.getString('token');

    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.get(
        Uri.parse(Getprojectendpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authtoken',
        },
      );

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> responseData = json.decode(response.body);
          apiResponse.data = ProjectModel.fromJson(responseData);
          print('data from actual request are ${apiResponse.data}');
          // successToast('data available');
          break;
        case 422:
          // Handle specific error cases
          break;
        default:
          // Handle other status codes
          break;
      }
    } catch (e) {
      apiResponse.error = "Something went wrong, try again later";
      // Handle errors
      // print('Error: $e');
    }
    return apiResponse;
  }
}
