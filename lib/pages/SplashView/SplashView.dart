import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:interiordesign_mobile/pages/Onboboarding/onboarding_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      Get.to(OnboardingView());
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 91, 90, 92),
      body: Center(
        child: Text(
          'InteriorDesign-Link',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
