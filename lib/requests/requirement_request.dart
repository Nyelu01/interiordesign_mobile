import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interiordesign_mobile/api.dart';
import 'package:interiordesign_mobile/end_point.dart';
import 'package:interiordesign_mobile/widgets/widget.dart';

class SubmitRequirementRequest {
  static Future<ApiResponse> submit(
    BuildContext context,
    String location,
    String serviceType,
    String projectType,
    String projectGrade,
    String description,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      // Print all collected data before making the POST request
      print('Collected Data:');
      print('projec_location: $location');
      print('service_type: $serviceType');
      print('project_type: $projectType');
      print('project_grade: $projectGrade');
      print('description: $description');

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      // Make POST request to the submission endpoint
      final response = await http.post(
        Uri.parse(requirementSubmissionEndpoint),
        body: json.encode({
          'projec_location': location,
          'service_type': serviceType,
          'project_type': projectType,
          'project_grade': projectGrade,
          'description': description,
          'client_id':
              2, // Ensure client_id and project_id are being sent if required
          'project_id': 2
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      Navigator.of(context).pop(); // Hide loading indicator

      switch (response.statusCode) {
        case 201:
          successToast("Submission successful");
          Navigator.of(context).pop(); // Go back to the previous screen
          break;
        case 422:
          final errors = jsonDecode(response.body);
          apiResponse.error = errors[errors.keys.elementAt(0)];
          errorToast('${apiResponse.error}');
          break;
        default:
          apiResponse.error = "Something went wrong, try again later";
      }
    } catch (e) {
      Navigator.of(context).pop(); // Hide loading indicator in case of error
      apiResponse.error = "Something went wrong, try again later";
      warningToast("Connection problem");
    }
    return apiResponse;
  }
}
