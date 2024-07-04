import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interiordesign_mobile/config/app_strings.dart';
import 'package:interiordesign_mobile/pages/Authentication/views/register_view.dart';
import 'package:interiordesign_mobile/requests/login_request.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Form(
        child: Padding(
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
                    AppStrings.helloWelcome,
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 91, 90, 92),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    AppStrings.loginToContinue,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 91, 90, 92),
                    ),
                  ),
                  SizedBox(
                    height: 56,
                  ),
                  TextFormField(
                    controller: emailController,
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
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: AppStrings.password,
                      // controller: passwordController,
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
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        loginRequest.login(
                          context,
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 91, 90, 92),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                          AppStrings.login), // The child parameter added here
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        AppStrings.dontHaveAccount,
                        style:
                            TextStyle(color: Color.fromARGB(255, 91, 90, 92)),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterView()));
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.blue),
                          child: Text(
                            AppStrings.signup,
                          )),
                    ],
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
