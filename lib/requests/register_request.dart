import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interiordesign_mobile/api.dart';
import 'package:interiordesign_mobile/end_point.dart';
import 'package:interiordesign_mobile/pages/Authentication/views/login_view.dart';
import 'package:interiordesign_mobile/widgets/widget.dart';

class Registerrequest {
  static Future<ApiResponse> register(
    context,
    String name,
    String phone,
    String email,
    String password,
    String location,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      // Print all collected data before making the POST request
      print('Collected Data:');
      print('email: $email');
      print('phone: $phone');
      print('Password: $password');
      print('location: $location');
      print('name: $name');

      // Make POST request to the registration endpoint
      final response = await http.post(
        Uri.parse(registrationendpoint),
        body: json.encode({
          'name': name,
          'phone': phone,
          'email': email,
          'password': password,
          'location': location, // Adding the photo property
          // Add other fields as needed
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      switch (response.statusCode) {
        case 201:
          successToast("success");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginView()));
          break;
        case 422:
          final errors = jsonDecode(response.body);
          apiResponse.error = errors[errors.keys.elementAt(0)];
          errorToast('$errors');
          break;
        default:
          apiResponse.error = "Something went wrong, try again later";
      }
    } catch (e) {
      apiResponse.error = "Something went wrong, try again later";
      // Handle errors
      warningToast("Connection problem");
    }
    return apiResponse;
  }
}
