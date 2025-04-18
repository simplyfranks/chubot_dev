import 'package:flutter/material.dart';

class taxiTabContent extends StatelessWidget {
  const taxiTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/TaxiDesign.png',
                height: 200,
                width: 300,
              ),
              Text(
                'Taxi and Pick Up services would be available \nin future update.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
