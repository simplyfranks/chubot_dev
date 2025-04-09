import 'package:flutter/material.dart';

class privacyWriteup extends StatelessWidget {
  const privacyWriteup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Your privacy policy content goes here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}