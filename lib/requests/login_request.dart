import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interiordesign_mobile/end_point.dart';
import 'package:interiordesign_mobile/screens/home.dart';
import 'package:interiordesign_mobile/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import http package

class loginRequest {
  static Future<void> login(
      BuildContext context, String email, String password) async {
    //I HAVE DEFINED ALL OF MY END POINT INSIDE THE api_end_points FILE AND IMPORT
    //THEM TO USE IN DIFFERENT FILES

    try {
      // Make POST request to the login endpoint
      final response = await http.post(Uri.parse(loginendpoint),
          body: json.encode({'email': email, 'password': password}),
          headers: {'Content-Type': 'application/json'});

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Parse the response body
        Map<String, dynamic> responseBody = json.decode(response.body);

        // Check if the response contains a user and token
        if (responseBody.containsKey('token')) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('token', responseBody['token']);
          await prefs.setInt('userId', responseBody['user']['id']);

          await prefs.setString('token', responseBody['token']);

          final token = prefs.getString('token');
          // successToast('$token');
          print('token retrieved from storage:  $token');
          print('Data saved to SharedPreferences:');

          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        } else {
          // Show error message if the response does not contain user and token
          // ignore: use_build_context_synchronously

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Invalid response from server.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Show error message if the response status code is not 200
        // ignore: use_build_context_synchronously
        Map<String, dynamic> responseBody = json.decode(response.body);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('$responseBody'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API request
      print('Error: $e');
      // ignore: use_build_context_synchronously
      errorToast("failed to login, No connection!");
    }
  }
}
