import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/appbar.dart';
import 'package:liontent/core/widgets/textfields.dart';

class contEmail extends StatefulWidget {
  const contEmail({super.key});

  @override
  State<contEmail> createState() => _contEmailState();
}

class _contEmailState extends State<contEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(closeOpera: () {}),
      body: Padding(
        padding: EdgeInsets.only(left: 18, right: 18, top: 20),
        child: Container(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter the following information',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'We\'ll use these info to create an account for you since you don\'t have one',
                  ),
                  SizedBox(height: 10),
                ],
              ),

              normalTextField(labelHint: 'Email Address'),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: normalTextField(labelHint: 'First Name')),
                  SizedBox(width: 10),
                  Expanded(child: normalTextField(labelHint: 'Surname')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
