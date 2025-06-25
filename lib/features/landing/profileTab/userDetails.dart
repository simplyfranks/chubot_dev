import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

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
  final TextEditingController matricNumberController = TextEditingController();

  // Country codes
  String selectedCountryCode = '+234'; // Default to Nigeria
  final List<Map<String, String>> countryCodes = [
    {'code': '+234', 'country': 'Nigeria 🇳🇬'},
    {'code': '+233', 'country': 'Ghana 🇬🇭'},
    {'code': '+225', 'country': 'Ivory Coast 🇨🇮'},
    {'code': '+228', 'country': 'Togo 🇹🇬'},
    {'code': '+229', 'country': 'Benin 🇧🇯'},
    {'code': '+232', 'country': 'Sierra Leone 🇸🇱'},
    {'code': '+231', 'country': 'Liberia 🇱🇷'},
    {'code': '+224', 'country': 'Guinea 🇬🇳'},
    {'code': '+221', 'country': 'Senegal 🇸🇳'},
    {'code': '+220', 'country': 'Gambia 🇬🇲'},
    {'code': '+44', 'country': 'United Kingdom 🇬🇧'},
    {'code': '+1', 'country': 'United States 🇺🇸'},
    {'code': '+49', 'country': 'Germany 🇩🇪'},
  ];

  // Emergency contacts
  List<EmergencyContact> emergencyContacts = [];

  // Form validation
  final _formKey = GlobalKey<FormState>();
  bool hasChanges = false;
  bool showedWarningDialog = false;

  // Gender selection
  String? selectedGender;
  List<String> genderOptions = ['Male', 'Female', 'Other'];

  // List of critical fields that can't be edited for 45 days
  final List<String> criticalFields = [
    'firstName',
    'lastName',
    'phone',
    'gender',
    'dateOfBirth',
    'email',
    'matricNumber',
  ];

  // Track lock status of each field
  Map<String, bool> fieldLockStatus = {};

  // Track remaining days for locked fields
  Map<String, int> fieldLockRemainingDays = {};

  // Profile image properties
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initLockedStatus();
    _loadUserData();
    _loadProfileImage();

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
      selectedCountryCode = prefs.getString('countryCode') ?? '+234';
      addressController.text = prefs.getString('address') ?? '';
      dateOfBirthController.text = prefs.getString('dateOfBirth') ?? '';
      occupationController.text = prefs.getString('occupation') ?? '';
      matricNumberController.text = prefs.getString('matricNumber') ?? '';
      selectedGender = prefs.getString('gender');

      // Load field lock states
      _loadFieldLockStatus();

      // Load emergency contacts using the dedicated method
      _loadEmergencyContacts();
    });
  }

  // Load field lock status
  Future<void> _loadFieldLockStatus() async {
    final prefs = await SharedPreferences.getInstance();

    // For each critical field, check if it's locked and until when
    for (var field in criticalFields) {
      final lastEditTime = prefs.getInt('${field}LastEdit');
      final fieldValue = prefs.getString(field) ?? '';

      // Only apply locks to fields that have values and have been edited before
      if (lastEditTime != null && fieldValue.isNotEmpty) {
        final lockUntil = DateTime.fromMillisecondsSinceEpoch(
          lastEditTime,
        ).add(Duration(days: 45));
        final now = DateTime.now();

        // Set locked state based on whether the lock period has expired
        fieldLockStatus[field] = now.isBefore(lockUntil);
        if (fieldLockStatus[field]!) {
          // Calculate days remaining in lock period
          final daysRemaining = lockUntil.difference(now).inDays;
          fieldLockRemainingDays[field] = daysRemaining;
        }
      } else {
        // If field is empty or never edited, it should not be locked
        fieldLockStatus[field] = false;
      }
    }
  }

  // Dedicated method to load emergency contacts
  Future<void> _loadEmergencyContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsJson = prefs.getStringList('emergencyContacts') ?? [];

    setState(() {
      emergencyContacts =
          contactsJson
              .map((json) => EmergencyContact.fromJson(jsonDecode(json)))
              .toList();
    });
  }

  // Save user data to SharedPreferences
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().millisecondsSinceEpoch;

    // Format the first name properly
    String firstName = firstNameController.text.trim();
    if (firstName.isNotEmpty) {
      firstName =
          firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
    }

    // Check which critical fields have changed and update their last edit time
    // Only update last edit time for non-empty fields
    if (prefs.getString('firstName') != firstName && firstName.isNotEmpty) {
      await prefs.setInt('firstNameLastEdit', now);
      fieldLockStatus['firstName'] = true;
    }

    if (prefs.getString('lastName') != lastNameController.text.trim() &&
        lastNameController.text.trim().isNotEmpty) {
      await prefs.setInt('lastNameLastEdit', now);
      fieldLockStatus['lastName'] = true;
    }

    if (prefs.getString('email') != emailController.text.trim() &&
        emailController.text.trim().isNotEmpty) {
      await prefs.setInt('emailLastEdit', now);
      fieldLockStatus['email'] = true;
    }

    if ((prefs.getString('phone') != phoneController.text.trim() ||
            prefs.getString('countryCode') != selectedCountryCode) &&
        phoneController.text.trim().isNotEmpty) {
      await prefs.setInt('phoneLastEdit', now);
      fieldLockStatus['phone'] = true;
    }

    if (prefs.getString('dateOfBirth') != dateOfBirthController.text.trim() &&
        dateOfBirthController.text.trim().isNotEmpty) {
      await prefs.setInt('dateOfBirthLastEdit', now);
      fieldLockStatus['dateOfBirth'] = true;
    }

    if (prefs.getString('gender') != selectedGender &&
        (selectedGender?.isNotEmpty ?? false)) {
      await prefs.setInt('genderLastEdit', now);
      fieldLockStatus['gender'] = true;
    }

    if (prefs.getString('matricNumber') != matricNumberController.text.trim() &&
        matricNumberController.text.trim().isNotEmpty) {
      await prefs.setInt('matricNumberLastEdit', now);
      fieldLockStatus['matricNumber'] = true;
    }

    // Save the actual data
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastNameController.text.trim());
    await prefs.setString('email', emailController.text.trim());
    await prefs.setString('phone', phoneController.text.trim());
    await prefs.setString('countryCode', selectedCountryCode);
    await prefs.setString('address', addressController.text.trim());
    await prefs.setString('dateOfBirth', dateOfBirthController.text.trim());
    await prefs.setString('occupation', occupationController.text.trim());
    await prefs.setString('matricNumber', matricNumberController.text.trim());
    await prefs.setString('gender', selectedGender ?? '');

    // Save emergency contacts using the dedicated method
    await _saveEmergencyContacts();

    // Update UI with locked fields
    setState(() {});
  }

  // Dedicated method to save emergency contacts
  Future<void> _saveEmergencyContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsJson =
        emergencyContacts
            .map((contact) => jsonEncode(contact.toJson()))
            .toList();
    await prefs.setStringList('emergencyContacts', contactsJson);
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
                  'Please note that once you save changes to the following fields, you will not be able to modify them again for 45 days:',
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

  // Helper method to build info list items
  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(Icons.info_outline, size: 12, color: Colors.blue),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.blue[700]),
            ),
          ),
        ],
      ),
    );
  }

  // Load profile image from shared preferences
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profileImagePath');

    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  // Save profile image to shared preferences
  Future<void> _saveProfileImage(File image) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Create a permanent copy of the image in app documents directory
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.png';
      final savedImage = await image.copy('${appDir.path}/$fileName');

      // Save the path
      await prefs.setString('profileImagePath', savedImage.path);

      setState(() {
        _profileImage = savedImage;
        hasChanges = true; // Mark that changes were made
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Remove profile image
  Future<void> _removeProfileImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('profileImagePath');

      setState(() {
        _profileImage = null;
        hasChanges = true; // Mark that changes were made
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture removed'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error removing profile picture: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Take picture with camera
  Future<void> _takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.front,
      );

      if (image != null) {
        await _saveProfileImage(File(image.path));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile picture updated'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to take photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        await _saveProfileImage(File(image.path));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile picture updated'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _initLockedStatus() {
    // Initialize lock status for all critical fields to false (unlocked)
    for (String field in criticalFields) {
      fieldLockStatus[field] = false;
      fieldLockRemainingDays[field] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure no empty fields are locked
    if (matricNumberController.text.isEmpty) {
      fieldLockStatus['matricNumber'] = false;
    }
    if (firstNameController.text.isEmpty) {
      fieldLockStatus['firstName'] = false;
    }
    if (lastNameController.text.isEmpty) {
      fieldLockStatus['lastName'] = false;
    }
    if (emailController.text.isEmpty) {
      fieldLockStatus['email'] = false;
    }
    if (phoneController.text.isEmpty) {
      fieldLockStatus['phone'] = false;
    }
    if (dateOfBirthController.text.isEmpty) {
      fieldLockStatus['dateOfBirth'] = false;
    }
    if (selectedGender == null || selectedGender!.isEmpty) {
      fieldLockStatus['gender'] = false;
    }

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
                          GestureDetector(
                            onTap: _showProfileImageOptions,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : null,
                              child:
                                  _profileImage == null
                                      ? Text(
                                        firstNameController.text.isNotEmpty
                                            ? firstNameController.text[0]
                                                .toUpperCase()
                                            : 'U',
                                        style: TextStyle(fontSize: 40),
                                      )
                                      : null,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
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
                  enabled: !fieldLockStatus['firstName']!,
                  tooltip:
                      fieldLockStatus['firstName']!
                          ? 'This field cannot be edited for ${fieldLockRemainingDays['firstName']} more days'
                          : null,
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
                  enabled: !fieldLockStatus['lastName']!,
                  tooltip:
                      fieldLockStatus['lastName']!
                          ? 'This field cannot be edited for ${fieldLockRemainingDays['lastName']} more days'
                          : null,
                ),

                // Gender Selection
                _buildDropdown(
                  label: 'Gender',
                  prefixIcon: Icons.person_outline,
                  value: selectedGender,
                  items: genderOptions,
                  onChanged:
                      fieldLockStatus['gender']!
                          ? null
                          : (newValue) {
                            setState(() {
                              selectedGender = newValue;
                              hasChanges = true;
                            });
                          },
                  tooltip:
                      fieldLockStatus['gender']!
                          ? 'This field cannot be edited for ${fieldLockRemainingDays['gender']} more days'
                          : null,
                ),

                // Date of Birth
                _buildTextField(
                  controller: dateOfBirthController,
                  label: 'Date of Birth',
                  prefixIcon: Icons.calendar_today,
                  readOnly: true,
                  enabled: !fieldLockStatus['dateOfBirth']!,
                  tooltip:
                      fieldLockStatus['dateOfBirth']!
                          ? 'This field cannot be edited for ${fieldLockRemainingDays['dateOfBirth']} more days'
                          : null,
                  onTap:
                      fieldLockStatus['dateOfBirth']!
                          ? null
                          : () async {
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
                  enabled: !fieldLockStatus['email']!,
                  tooltip:
                      fieldLockStatus['email']!
                          ? 'This field cannot be edited for ${fieldLockRemainingDays['email']} more days'
                          : null,
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
                _buildPhoneNumberField(),

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
                  enabled: !fieldLockStatus['matricNumber']!,
                  tooltip:
                      fieldLockStatus['matricNumber']!
                          ? 'This field cannot be edited for ${fieldLockRemainingDays['matricNumber']} more days'
                          : null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null; // Matric number is optional
                    }
                    // Validate format: YYYY/XXXXXX or YYYY/XXXXXXX
                    if (!RegExp(r'^\d{4}/\d{6,7}$').hasMatch(value)) {
                      return 'Invalid Matric number format. Use YYYY/XXXXXX ';
                    }
                    // Validate year part (should be reasonable, e.g., not future year)
                    int year = int.parse(value.split('/')[0]);
                    int currentYear = DateTime.now().year;
                    if (year < 1955 || year > currentYear) {
                      return 'Year should be between 1955 and $currentYear';
                    }
                    return null;
                  },
                ),

                // Occupation
                _buildTextField(
                  controller: occupationController,
                  label: 'Occupation',
                  prefixIcon: FontAwesomeIcons.briefcase,
                ),

                SizedBox(height: 32),

                // Emergency Contacts Section
                _buildEmergencyContactsSection(),

                SizedBox(height: 32),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed:
                        hasChanges
                            ? () async {
                              if (_formKey.currentState!.validate()) {
                                // Check if any critical fields were changed
                                bool hasCriticalChanges =
                                    await _hasCriticalFieldChanges();
                                if (hasCriticalChanges) {
                                  // Show confirmation dialog
                                  bool shouldContinue =
                                      await _showSaveConfirmationDialog();
                                  if (!shouldContinue) {
                                    return; // User canceled the save
                                  }
                                }

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

                                // Return to previous screen with a result indicating profile was updated
                                Navigator.pop(context, true);
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
    bool enabled = true,
    String? tooltip,
  }) {
    final bool isLocked = !enabled;
    final String fieldName =
        label
            .split('(')[0]
            .trim(); // Get clean field name without additional text
    final String lockMessage =
        isLocked
            ? ' ($fieldName is locked for ${_getRemainingDaysText(label)})'
            : '';

    final textField = Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines,
            enabled: enabled,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: enabled ? Color(0xff1c6f0f) : Colors.grey,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: enabled ? colors4Liontent.primary : Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colors4Liontent.primary,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              filled: true,
              fillColor: enabled ? Colors.white : Colors.grey.shade100,
              suffixIcon:
                  !enabled
                      ? Icon(Icons.lock, color: Colors.red[300], size: 18)
                      : null,
            ),
          ),
          if (isLocked)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Row(
                children: [
                  Icon(Icons.timer, size: 14, color: Colors.orange[700]),
                  SizedBox(width: 4),
                  Text(
                    _getRemainingDaysText(label),
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    if (tooltip != null && !enabled) {
      return Tooltip(message: tooltip + lockMessage, child: textField);
    }

    return textField;
  }

  // Get remaining days text based on field name
  String _getRemainingDaysText(String fieldLabel) {
    String fieldKey = '';

    // Map label to field key
    if (fieldLabel.contains('First Name')) {
      fieldKey = 'firstName';
    } else if (fieldLabel.contains('Last Name'))
      fieldKey = 'lastName';
    else if (fieldLabel.contains('Email'))
      fieldKey = 'email';
    else if (fieldLabel.contains('Phone'))
      fieldKey = 'phone';
    else if (fieldLabel.contains('Date of Birth'))
      fieldKey = 'dateOfBirth';
    else if (fieldLabel.contains('Gender'))
      fieldKey = 'gender';
    else if (fieldLabel.contains('Matric'))
      fieldKey = 'matricNumber';

    // Get days remaining
    final days = fieldLockRemainingDays[fieldKey] ?? 0;

    if (days <= 0) return "Unlocking soon";
    if (days == 1) return "1 day remaining";
    return "$days days remaining";
  }

  // Helper method to build dropdown fields
  Widget _buildDropdown({
    required String label,
    required IconData prefixIcon,
    required String? value,
    required List<String> items,
    required Function(String?)? onChanged,
    String? tooltip,
  }) {
    final bool isLocked = onChanged == null;
    final String fieldName = label.split('(')[0].trim();
    final String lockMessage =
        isLocked
            ? ' ($fieldName is locked for ${_getRemainingDaysText(label)})'
            : '';

    final dropdownField = Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: onChanged != null ? Color(0xff1c6f0f) : Colors.grey,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color:
                    onChanged != null ? colors4Liontent.primary : Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: colors4Liontent.primary,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              filled: true,
              fillColor:
                  onChanged != null ? Colors.white : Colors.grey.shade100,
              suffixIcon:
                  onChanged == null
                      ? Icon(Icons.lock, color: Colors.red[300], size: 18)
                      : null,
            ),
            items:
                items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
            onChanged: onChanged,
            icon: Icon(
              Icons.arrow_drop_down,
              color: onChanged != null ? colors4Liontent.primary : Colors.grey,
            ),
          ),
          if (isLocked)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Row(
                children: [
                  Icon(Icons.timer, size: 14, color: Colors.orange[700]),
                  SizedBox(width: 4),
                  Text(
                    _getRemainingDaysText(label),
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    if (tooltip != null && onChanged == null) {
      return Tooltip(message: tooltip + lockMessage, child: dropdownField);
    }

    return dropdownField;
  }

  // Build phone number field with country code
  Widget _buildPhoneNumberField() {
    final bool isPhoneLocked = fieldLockStatus['phone'] ?? false;
    final String lockMessage =
        isPhoneLocked
            ? ' (Phone Number is locked for ${_getRemainingDaysText("Phone Number")})'
            : '';
    final phoneTooltip =
        isPhoneLocked
            ? 'This field cannot be edited for ${fieldLockRemainingDays["phone"]} more days'
            : null;

    final phoneField = Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isPhoneLocked ? Colors.grey.shade100 : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isPhoneLocked ? Colors.grey.shade300 : Colors.grey,
              ),
            ),
            child: Row(
              children: [
                // Country code dropdown (smaller width)
                SizedBox(
                  width: 90,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: selectedCountryCode,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color:
                              isPhoneLocked
                                  ? Colors.grey
                                  : colors4Liontent.primary,
                          size: 20,
                        ),
                        iconSize: 20,
                        elevation: 16,
                        isDense: true,
                        style: TextStyle(
                          color: isPhoneLocked ? Colors.grey : Colors.black,
                          fontSize: 14,
                        ),
                        onChanged:
                            isPhoneLocked
                                ? null
                                : (String? newValue) {
                                  setState(() {
                                    selectedCountryCode = newValue!;
                                    hasChanges = true;
                                  });
                                },
                        items:
                            countryCodes.map<DropdownMenuItem<String>>((
                              Map<String, String> country,
                            ) {
                              return DropdownMenuItem<String>(
                                value: country['code'],
                                child: Text(
                                  country['code']!,
                                  style: TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                        dropdownColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ),

                // Vertical divider
                Container(height: 30, width: 1, color: Colors.grey.shade300),

                // Phone number input
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    enabled: !isPhoneLocked,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length < 10 || value.length > 11) {
                        return 'Phone number must be 10-11 digits';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Only numbers allowed';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        color: isPhoneLocked ? Colors.grey : Color(0xff1c6f0f),
                      ),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color:
                            isPhoneLocked
                                ? Colors.grey
                                : colors4Liontent.primary,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      counterText: '',
                      hintText: 'e.g. 8012345678',
                      suffixIcon:
                          isPhoneLocked
                              ? Icon(
                                Icons.lock,
                                color: Colors.red[300],
                                size: 18,
                              )
                              : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isPhoneLocked)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0),
              child: Row(
                children: [
                  Icon(Icons.timer, size: 14, color: Colors.orange[700]),
                  SizedBox(width: 4),
                  Text(
                    _getRemainingDaysText("Phone Number"),
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    if (phoneTooltip != null && isPhoneLocked) {
      return Tooltip(message: phoneTooltip + lockMessage, child: phoneField);
    }

    return phoneField;
  }

  // Show country code selection bottom sheet
  void _showCountryCodeSelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Country Code',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: countryCodes.length,
                    itemBuilder: (context, index) {
                      final country = countryCodes[index];
                      return ListTile(
                        title: Text('${country['country']}'),
                        subtitle: Text('${country['code']}'),
                        onTap: () {
                          setState(() {
                            selectedCountryCode = country['code']!;
                            hasChanges = true;
                          });
                          Navigator.pop(context);
                        },
                        selected: selectedCountryCode == country['code'],
                        selectedTileColor: colors4Liontent.primary.withOpacity(
                          0.1,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  // Show dialog to set relationship
  void _showRelationshipDialog(int index) {
    final TextEditingController relationshipController =
        TextEditingController();
    relationshipController.text = emergencyContacts[index].relationship;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Contact Relationship'),
            content: TextField(
              controller: relationshipController,
              decoration: InputDecoration(
                labelText: 'Relationship (e.g., Parent, Sibling)',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    emergencyContacts[index].relationship =
                        relationshipController.text;
                    hasChanges = true;
                  });

                  // Save emergency contacts immediately when relationship is updated
                  _saveEmergencyContacts();

                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: colors4Liontent.primary,
                  foregroundColor: Colors.white,
                ),
                child: Text('Save'),
              ),
            ],
          ),
    );
  }

  // Remove emergency contact and update storage
  void _removeContact(int index) {
    setState(() {
      emergencyContacts.removeAt(index);
      hasChanges = true;
    });

    // Save emergency contacts immediately when removed
    _saveEmergencyContacts();
  }

  // Add contact manually
  void _addManualContact() {
    if (emergencyContacts.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You can only add up to 3 emergency contacts'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController relationshipController =
        TextEditingController();
    String contactCountryCode = '+234';

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: Text('Add Emergency Contact'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Phone number with country code
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Country code dropdown
                            SizedBox(
                              width: 100,
                              child: DropdownButtonFormField<String>(
                                value: contactCountryCode,
                                decoration: InputDecoration(
                                  labelText: 'Code',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 10,
                                  ),
                                ),
                                items:
                                    countryCodes.map((country) {
                                      return DropdownMenuItem<String>(
                                        value: country['code'],
                                        child: Text(
                                          '${country['code']}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setDialogState(() {
                                    contactCountryCode = value!;
                                  });
                                },
                                isDense: true,
                              ),
                            ),
                            SizedBox(width: 8),
                            // Phone number field
                            Expanded(
                              child: TextField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                maxLength: 11,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(),
                                  hintText: 'e.g. 8012345678',
                                  counterText: '',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: relationshipController,
                          decoration: InputDecoration(
                            labelText: 'Relationship',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (nameController.text.trim().isEmpty ||
                            phoneController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Name and phone number are required',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Validate phone number
                        final phoneText = phoneController.text.trim();
                        if (phoneText.length < 10 ||
                            phoneText.length > 11 ||
                            !RegExp(r'^[0-9]+$').hasMatch(phoneText)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Phone number must be 10-11 digits',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        setState(() {
                          emergencyContacts.add(
                            EmergencyContact(
                              name: nameController.text.trim(),
                              phoneNumber: phoneController.text.trim(),
                              relationship: relationshipController.text.trim(),
                              countryCode: contactCountryCode,
                            ),
                          );
                          hasChanges = true;
                        });

                        // Save emergency contacts immediately when added
                        _saveEmergencyContacts();

                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: colors4Liontent.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Save'),
                    ),
                  ],
                ),
          ),
    );
  }

  // Pick contact from phone contacts
  Future<void> _pickContact() async {
    if (emergencyContacts.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You can only add up to 3 emergency contacts'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Just use the manual contact entry for now
    _addManualContact();
  }

  // Emergency contacts section widget
  Widget _buildEmergencyContactsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Emergency Contacts (${emergencyContacts.length}/3)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors4Liontent.primary,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // New button to pick from contacts
                IconButton(
                  onPressed:
                      emergencyContacts.length >= 3 ? null : _pickContact,
                  icon: Icon(
                    Icons.contacts,
                    color:
                        emergencyContacts.length >= 3
                            ? Colors.grey
                            : colors4Liontent.primary,
                  ),
                  tooltip: 'Select from Phone Contacts',
                ),
                // Manual add button
                IconButton(
                  onPressed:
                      emergencyContacts.length >= 3 ? null : _addManualContact,
                  icon: Icon(
                    Icons.person_add,
                    color:
                        emergencyContacts.length >= 3
                            ? Colors.grey
                            : colors4Liontent.primary,
                  ),
                  tooltip: 'Add Manually',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...emergencyContacts.asMap().entries.map((entry) {
          final index = entry.key;
          final contact = entry.value;
          return Card(
            margin: EdgeInsets.only(bottom: 8),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: colors4Liontent.primary.withOpacity(0.2),
                child: Icon(Icons.person, color: colors4Liontent.primary),
              ),
              title: Text(
                contact.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${contact.countryCode} ${contact.phoneNumber}'),
                  if (contact.relationship.isNotEmpty)
                    Text(
                      'Relationship: ${contact.relationship}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, size: 20),
                    onPressed: () => _showRelationshipDialog(index),
                    tooltip: 'Edit Relationship',
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, size: 20, color: Colors.red),
                    onPressed: () => _removeContact(index),
                    tooltip: 'Remove Contact',
                  ),
                ],
              ),
            ),
          );
        }),
        if (emergencyContacts.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Icon(Icons.contact_phone, color: Colors.grey[400], size: 40),
                SizedBox(height: 8),
                Text(
                  'No emergency contacts added yet',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  'Tap + to add contacts',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Check if any critical fields were changed
  Future<bool> _hasCriticalFieldChanges() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('firstName') != firstNameController.text.trim()) {
      return true;
    }
    if (prefs.getString('lastName') != lastNameController.text.trim()) {
      return true;
    }
    if (prefs.getString('email') != emailController.text.trim()) return true;
    if (prefs.getString('phone') != phoneController.text.trim()) return true;
    if (prefs.getString('countryCode') != selectedCountryCode) return true;
    if (prefs.getString('dateOfBirth') != dateOfBirthController.text.trim()) {
      return true;
    }
    if (prefs.getString('gender') != selectedGender) return true;
    if (prefs.getString('matricNumber') != matricNumberController.text.trim()) {
      return true;
    }

    return false;
  }

  // Show confirmation dialog when saving critical fields
  Future<bool> _showSaveConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Column(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.amber[700],
                    size: 48,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'IMPORTANT NOTICE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.amber[800],
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
                    'You are about to save changes to restricted fields:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'These fields cannot be edited again for 45 days after saving. Please verify that all information is correct.',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.amber[800],
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'This restriction is in place to maintain data integrity. Are you sure you want to proceed?',
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Cancel
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[800],
                  ),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Confirm
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: colors4Liontent.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Yes, Save Changes'),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.amber.shade300, width: 1.5),
              ),
              backgroundColor: Colors.white,
            );
          },
        ) ??
        false; // Default to false if dialog is dismissed
  }

  // Show profile image options
  void _showProfileImageOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              if (_profileImage != null)
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove current photo'),
                  onTap: () {
                    Navigator.pop(context);
                    _removeProfileImage();
                  },
                ),
            ],
          ),
    );
  }
}

// Emergency Contact Model
class EmergencyContact {
  String name;
  String phoneNumber;
  String relationship;
  String countryCode;

  EmergencyContact({
    required this.name,
    required this.phoneNumber,
    required this.relationship,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'relationship': relationship,
      'countryCode': countryCode,
    };
  }

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      relationship: json['relationship'] ?? '',
      countryCode: json['countryCode'] ?? '+234',
    );
  }
}
