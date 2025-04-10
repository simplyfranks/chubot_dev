import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liontent/features/authentication/authPage.dart';

class demospinner extends StatelessWidget {
  final Color pageColor;
  final Color spinnerColor;
  final Color objectColor;
  const demospinner({
    super.key,
    required this.pageColor,
    required this.spinnerColor,
    required this.objectColor,
  });

  @override
  Widget build(BuildContext context) {
    // Start the delay function immediately when this screen loads.
    Future.delayed(const Duration(seconds: 6), () {
      // Navigate to authPage after 8 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const authenticate(),
        ), // Replace with your actual AuthPage widget
      );
    });

    return Scaffold(
      backgroundColor: pageColor,
      body: Center(
        child: CircularProgressIndicator(
          // Background color of the circle (the unfilled portion)
          backgroundColor: spinnerColor, // Set this to the color of your choice
          // Rotating color of the spinner
          valueColor: AlwaysStoppedAnimation<Color>(
            objectColor,
          ), // Set this to the color of your choice
          // You can customize the stroke width to make the circle thicker or thinner
          strokeWidth: 6.0, // Adjust thickness as needed
        ),
      ),
    );
  }
}
