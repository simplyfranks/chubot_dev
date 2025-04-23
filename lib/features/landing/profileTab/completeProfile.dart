import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class completeUserProfile extends StatefulWidget {
  const completeUserProfile({super.key});

  @override
  State<completeUserProfile> createState() => _completeUserProfileState();
}

class _completeUserProfileState extends State<completeUserProfile> {
  // Controllers for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController emergencyContactController =
      TextEditingController();
  final TextEditingController matricNumberController = TextEditingController();

  // Form validation
  final _formKey = GlobalKey<FormState>();
  bool hasChanges = false;
  bool showedWarningDialog = false;

  // Gender selection
  String? selectedGender;
  List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    // Show the warning dialog after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showRestrictionWarningDialog();
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dateOfBirthController.dispose();
    occupationController.dispose();
    emergencyContactController.dispose();
    matricNumberController.dispose();
    super.dispose();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      firstNameController.text = prefs.getString('firstName') ?? '';
      lastNameController.text = prefs.getString('lastName') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneController.text = prefs.getString('phone') ?? '';
      addressController.text = prefs.getString('address') ?? '';
      dateOfBirthController.text = prefs.getString('dateOfBirth') ?? '';
      occupationController.text = prefs.getString('occupation') ?? '';
      emergencyContactController.text =
          prefs.getString('emergencyContact') ?? '';
      matricNumberController.text = prefs.getString('matricNumber') ?? '';
      selectedGender = prefs.getString('gender');
    });
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Format the first name properly
    String firstName = firstNameController.text.trim();
    if (firstName.isNotEmpty) {
      firstName =
          firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
    }

    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastNameController.text.trim());
    await prefs.setString('email', emailController.text.trim());
    await prefs.setString('phone', phoneController.text.trim());
    await prefs.setString('address', addressController.text.trim());
    await prefs.setString('dateOfBirth', dateOfBirthController.text.trim());
    await prefs.setString('occupation', occupationController.text.trim());
    await prefs.setString(
      'emergencyContact',
      emergencyContactController.text.trim(),
    );
    await prefs.setString('matricNumber', matricNumberController.text.trim());
    await prefs.setString('gender', selectedGender ?? '');
  }

  // Show warning dialog about critical field edit restrictions
  void _showRestrictionWarningDialog() {
    if (!showedWarningDialog) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 56),
                SizedBox(height: 8),
                Text(
                  'IMPORTANT NOTICE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please note that once you save changes to the following fields, you will not be able to modify them again for a fixed period of time:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                _buildWarningItem('First Name'),
                _buildWarningItem('Last Name'),
                _buildWarningItem('Phone Number'),
                _buildWarningItem('Gender'),
                _buildWarningItem('Date of Birth'),
                _buildWarningItem('Email'),
                _buildWarningItem('Matric Number'),
                SizedBox(height: 12),
                Text(
                  'Please ensure all information is correct before saving.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    showedWarningDialog = true;
                  });
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: colors4Liontent.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text('I Understand'),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.red, width: 2),
            ),
            backgroundColor: Color(0xFFFFF8F8),
          );
        },
      );
    }
  }

  // Helper method to build warning list items
  Widget _buildWarningItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: Colors.red),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      appBar: AppBar(
        backgroundColor: colors4Liontent.primary,
        title: Text(
          'Complete Your Profile',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            hasChanges = true;
          });
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Section
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            child:
                                firstNameController.text.isNotEmpty
                                    ? Text(
                                      firstNameController.text[0].toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: colors4Liontent.primary,
                                      ),
                                    )
                                    : Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.grey[600],
                                    ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: colors4Liontent.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Profile Picture',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),
                _buildSectionTitle('Basic Information'),

                // First Name
                _buildTextField(
                  controller: firstNameController,
                  label: 'First Name',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),

                // Last Name
                _buildTextField(
                  controller: lastNameController,
                  label: 'Last Name',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),

                // Gender Selection
                _buildDropdown(
                  label: 'Gender',
                  prefixIcon: Icons.person_outline,
                  value: selectedGender,
                  items: genderOptions,
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                      hasChanges = true;
                    });
                  },
                ),

                // Date of Birth
                _buildTextField(
                  controller: dateOfBirthController,
                  label: 'Date of Birth',
                  prefixIcon: Icons.calendar_today,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: colors4Liontent.primary,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      setState(() {
                        dateOfBirthController.text = DateFormat(
                          'dd/MM/yyyy',
                        ).format(pickedDate);
                        hasChanges = true;
                      });
                    }
                  },
                ),

                SizedBox(height: 24),
                _buildSectionTitle('Contact Information'),

                // Email
                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                // Phone
                _buildTextField(
                  controller: phoneController,
                  label: 'Phone Number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),

                // Address
                _buildTextField(
                  controller: addressController,
                  label: 'Address',
                  prefixIcon: Icons.home_outlined,
                  maxLines: 2,
                ),

                SizedBox(height: 24),
                _buildSectionTitle('Additional Information'),

                // Matric Number
                _buildTextField(
                  controller: matricNumberController,
                  label: 'Matric No. (if any)',
                  prefixIcon: FontAwesomeIcons.graduationCap,
                ),

                // Occupation
                _buildTextField(
                  controller: occupationController,
                  label: 'Occupation',
                  prefixIcon: FontAwesomeIcons.briefcase,
                ),

                // Emergency Contact
                _buildTextField(
                  controller: emergencyContactController,
                  label: 'Emergency Contact',
                  prefixIcon: Icons.contact_phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 32),

                // Save Button
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        hasChanges
                            ? () async {
                              if (_formKey.currentState!.validate()) {
                                await _saveUserData();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Profile updated successfully',
                                    ),
                                    backgroundColor: colors4Liontent.primary,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                setState(() {
                                  hasChanges = false;
                                });
                              }
                            }
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors4Liontent.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors4Liontent.primary,
          ),
        ),
        Divider(color: colors4Liontent.primary.withOpacity(0.3), thickness: 1),
        SizedBox(height: 10),
      ],
    );
  }

  // Helper method to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        readOnly: readOnly,
        onTap: onTap,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xff1c6f0f)),
          prefixIcon: Icon(prefixIcon, color: colors4Liontent.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors4Liontent.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Helper method to build dropdown fields
  Widget _buildDropdown({
    required String label,
    required IconData prefixIcon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xff1c6f0f)),
          prefixIcon: Icon(prefixIcon, color: colors4Liontent.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colors4Liontent.primary, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          filled: true,
          fillColor: Colors.white,
        ),
        items:
            items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
        onChanged: onChanged,
        icon: Icon(Icons.arrow_drop_down, color: colors4Liontent.primary),
      ),
    );
  }
}
