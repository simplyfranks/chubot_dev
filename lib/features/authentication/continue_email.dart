import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/appbar.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:liontent/core/widgets/textfields.dart';
import 'package:liontent/features/landing/landing_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class contEmail extends StatefulWidget {
  const contEmail({super.key});

  @override
  State<contEmail> createState() => _contEmailState();
}

class _contEmailState extends State<contEmail> {
  String? selectedGender; // Variable to store the selected gender
  bool showWarning = false; // Flag to control the warning visibility

  // Controllers for the text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  // Error state variables
  bool hasError = false;
  bool emailError = false;
  bool firstNameError = false;
  bool surnameError = false;
  bool genderError = false;

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  // Validate all fields
  bool validateFields() {
    setState(() {
      emailError = emailController.text.trim().isEmpty;
      firstNameError = firstNameController.text.trim().isEmpty;
      surnameError = surnameController.text.trim().isEmpty;
      genderError = selectedGender == null;

      hasError = emailError || firstNameError || surnameError || genderError;
    });

    return !hasError;
  }

  // Save user data to shared preferences
  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String firstName = firstNameController.text.trim();
    // Format name - capitalize first letter, rest lowercase
    if (firstName.isNotEmpty) {
      firstName =
          firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
    }

    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', surnameController.text.trim());
    await prefs.setString('email', emailController.text.trim());
    await prefs.setString('gender', selectedGender ?? '');
  }

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
            // Custom text field with error state
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(
                  color: emailError ? Colors.red : Color(0xff1c6f0f),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: emailError ? Colors.red : Colors.green,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: emailError ? Colors.red : Colors.grey,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        color: firstNameError ? Colors.red : Color(0xff1c6f0f),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: firstNameError ? Colors.red : Colors.green,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: firstNameError ? Colors.red : Colors.grey,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      labelText: 'Surname',
                      labelStyle: TextStyle(
                        color: surnameError ? Colors.red : Color(0xff1c6f0f),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: surnameError ? Colors.red : Colors.green,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: surnameError ? Colors.red : Colors.grey,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
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
                    labelStyle: TextStyle(
                      color: genderError ? Colors.red : Color(0xff1c6f0f),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: genderError ? Colors.red : Colors.green,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: genderError ? Colors.red : Colors.grey,
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
                      genderError = false;
                      showWarning =
                          value ==
                          'Otherwise'; // Show warning if "Otherwise" is selected
                    });
                  },
                  hint: Text('Select Gender'),
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

            // Form validation error message
            if (hasError) ...[
              const SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFD3D3),
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "These are compulsory fields that must be filled by the user",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            Expanded(child: SizedBox()),
            lengthButton1Light(
              navigateTo: () async {
                if (validateFields()) {
                  await saveUserData(); // Save data before navigation
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => landingPageSearch(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
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
