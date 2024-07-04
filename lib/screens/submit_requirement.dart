import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interiordesign_mobile/config/app_strings.dart';
import 'package:interiordesign_mobile/widgets/locations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitRequirement extends StatefulWidget {
  final int projectId;

  const SubmitRequirement({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<SubmitRequirement> createState() => _SubmitRequirementState();
}

class _SubmitRequirementState extends State<SubmitRequirement> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedServiceType;
  String? _selectedProjectType;
  String? _selectedProjectGrade;

  // Updated projectGrades list with descriptive words
  List<String> projectGrades = [
    '1 (Basic)',
    '2 (Standard)',
    '3 (Enhanced)',
    '4 (Premium)',
    '5 (High-standard)'
  ];

  List<String> serviceTypes = ['Interior Decoration', 'Interior Furnishing'];
  List<String> projectTypes = ['Official', 'Luxury'];

  Future<void> _submitRequirements() async {
    // Collect data from form
    String location = _locationController.text;
    String serviceType = _selectedServiceType ?? '';
    String projectType = _selectedProjectType ?? '';
    String projectGrade = _selectedProjectGrade ?? '';
    String description = _descriptionController.text;

    try {
      // Retrieve user ID and token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId =
          prefs.getInt('userId'); // Assuming you stored the user ID as 'userId'
      String? token = prefs.getString('token');

      if (token == null || userId == null) {
        print('User ID or token not found in SharedPreferences.');
        return; // Exit function if token or user ID is null
      }

      // Prepare data payload including user ID
      var data = {
        'client_id': userId,
        'project_id': widget.projectId, // Use widget.projectId here
        'project_location': location,
        'project_grade': projectGrade,
        'service_type': serviceType,
        'project_type': projectType,
        'description': description,
      };

      // Make POST request with token in headers
      var url = Uri.parse('http://192.168.242.51:8000/api/requirements');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Include token in Authorization header
        },
        body: jsonEncode(data),
      );

      // Handle response
      if (response.statusCode == 200) {
        // Successful submission
        var responseData = jsonDecode(response.body);
        print('Requirements submitted successfully: $responseData');

        // Show success message and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Requirements submitted successfully!'),
          ),
        );

        // Wait for the SnackBar to finish and then pop the route
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
      } else {
        // Failed submission
        print('Failed to submit requirements: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Handle error, show error message to user
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error submitting requirements: $e');
      // Show error message to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requirements'),
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                AppStrings.submitrequirement,
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 91, 90, 92),
                ),
              ),
              SizedBox(height: 36),
              RegionList(
                controller: _locationController,
                labelText: 'Select location of project',
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedServiceType,
                onChanged: (newValue) {
                  setState(() {
                    _selectedServiceType = newValue;
                  });
                },
                items: serviceTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Service Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedProjectType,
                onChanged: (newValue) {
                  setState(() {
                    _selectedProjectType = newValue;
                  });
                },
                items: projectTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Project Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedProjectGrade,
                onChanged: (newValue) {
                  setState(() {
                    _selectedProjectGrade = newValue;
                  });
                },
                items: projectGrades.map((grade) {
                  return DropdownMenuItem(
                    value: grade,
                    child: Text(grade),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Project Grade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _submitRequirements,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 91, 90, 92),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(AppStrings.submit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
