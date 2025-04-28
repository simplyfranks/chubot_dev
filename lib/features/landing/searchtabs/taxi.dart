import 'package:flutter/material.dart';

class taxiTabContent extends StatelessWidget {
  const taxiTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Responsive image that scales with screen size
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * 0.8,
                      maxHeight: screenSize.height * 0.4,
                    ),
                    child: Image.asset(
                      'assets/images/TaxiDesign.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 24),
                  // Text with proper constraints
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * 0.9,
                    ),
                    child: Text(
                      'Taxi and Pick Up services would be available in future update.',
                      style: TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Additional info with responsive layout
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * 0.9,
                    ),
                    child: Text(
                      'We are working on integrating transportation services to enhance your travel experience.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
