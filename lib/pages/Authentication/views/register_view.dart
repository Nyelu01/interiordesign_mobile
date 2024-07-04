import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interiordesign_mobile/api.dart';
import 'package:interiordesign_mobile/requests/register_request.dart';
import 'package:interiordesign_mobile/widgets/locations.dart';
import 'package:interiordesign_mobile/config/app_strings.dart';
import 'package:interiordesign_mobile/pages/Authentication/views/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
// processing start
  void _registerWithPermissionCheck() async {
    ApiResponse response = await Registerrequest.register(
      context,
      _nameController.text,
      _phoneController.text,
      _emailController.text,
      _passwordController.text,
      _locationController.text,
    );

    if (response.error == null) {
      setState(() {
        isRegistrationLoading = false;
      });
    } else {
      setState(() {
        isRegistrationLoading = false;
      });
    }
  }
// processing edn here

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool isRegistrationLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.only(top: 72.0),
        child: SingleChildScrollView(
            child: SizedBox(
          // defining the height of the device
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(24), //key for form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  AppStrings.registerHere,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 91, 90, 92),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 36,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: AppStrings.name,
                    prefixIcon: Icon(FontAwesomeIcons.user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: AppStrings.phoneNumber,
                    prefixIcon: Icon(FontAwesomeIcons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: AppStrings.email,
                    prefixIcon: Icon(FontAwesomeIcons.envelope),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.password,
                    prefixIcon: Icon(FontAwesomeIcons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                RegionList(
                  controller: _locationController,
                  labelText: 'your location',
                ), //display the dropdownlist of regions of tanzania
                SizedBox(
                  height: 16,
                ),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: isRegistrationLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isRegistrationLoading = true;
                            });
                            _registerWithPermissionCheck();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 91, 90, 92),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(AppStrings.register),
                        ),
                ),

                Row(
                  children: [
                    Text(
                      AppStrings.alreadyhaveaccount,
                      style: TextStyle(color: Color.fromARGB(255, 91, 90, 92)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.blue),
                        child: Text(
                          AppStrings.signin,
                        )),
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
