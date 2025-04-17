import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/appbar.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:liontent/core/widgets/textfields.dart';
import 'package:liontent/features/landing/landing_search.dart';

class contEmail extends StatefulWidget {
  const contEmail({super.key});

  @override
  State<contEmail> createState() => _contEmailState();
}

class _contEmailState extends State<contEmail> {
  String? selectedGender; // Variable to store the selected gender
  bool showWarning = false; // Flag to control the warning visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(closeOpera: () {}),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter the following information',
                  style: const TextStyle(fontSize: 20),
                ),
                const Text(
                  'We\'ll use these info to create an account for you since you don\'t have one',
                ),
                const SizedBox(height: 10),
              ],
            ),
            normalTextField(labelHint: 'Email Address'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: normalTextField(labelHint: 'First Name')),
                const SizedBox(width: 10),
                Expanded(child: normalTextField(labelHint: 'Surname')),
              ],
            ),
            const SizedBox(height: 10),
            // Dropdown for gender selection
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: const TextStyle(color: Color(0xff1c6f0f)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                  ),
                  value: selectedGender,
                  items: [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                    DropdownMenuItem(
                      value: 'Otherwise',
                      child: Text('Otherwise'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                      showWarning =
                          value ==
                          'Otherwise'; // Show warning if "Otherwise" is selected
                    });
                  },
                ),
                if (showWarning) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(5),
                    // height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD3D3),
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.red, size: 20),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Choosing this option may hide some gender-specific results from you.',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            Expanded(child: SizedBox()),
            lengthButton1Light(
              navigateTo: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => landingPageSearch()),
                  (Route<dynamic> route) => false,
                );
              },
              widgetchoice: Text(
                'Continue',
                style: TextStyle(color: colors4Liontent.secondary),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
