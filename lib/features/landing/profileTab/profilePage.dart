import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:liontent/features/landing/profileTab/completeProfile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:math' show pi;

// Custom painter for circular progress indicator
class ProfileProgressPainter extends CustomPainter {
  final double progress; // Value from 0.0 to 1.0
  final Color progressColor;
  final Color backgroundColor;

  ProfileProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.9; // Slightly smaller than container
    final strokeWidth = 8.0;

    // Draw background circle
    final backgroundPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final progressPaint =
        Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    final progressAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(ProfileProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}

class usersProfile extends StatefulWidget {
  const usersProfile({super.key});

  @override
  State<usersProfile> createState() => _usersProfileState();
}

class _usersProfileState extends State<usersProfile> {
  String userName = "User"; // Default name
  File? _profileImage;
  double _profileProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _loadUserData();

    // Recalculate progress every time the screen is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateProfileProgress();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Get profile image path
    final imagePath = prefs.getString('profileImagePath');

    setState(() {
      // Get the user's first name, defaulting to "User" if not found
      userName = prefs.getString('firstName') ?? "User";

      // Set profile image if available
      if (imagePath != null) {
        final imageFile = File(imagePath);
        if (imageFile.existsSync()) {
          _profileImage = imageFile;
        }
      }

      // Update progress indicator after loading data
      _profileProgress = _calculateProfileProgress();
    });
  }

  // Calculate the profile completion percentage
  double _calculateProfileProgress() {
    final prefs = SharedPreferences.getInstance();
    int filledFields = 0;
    int totalFields =
        12; // Total number of tracked fields including 3 emergency contacts

    // This will run asynchronously, but we'll use the cached values for a quick UI update
    prefs.then((prefs) {
      // Basic information fields (4)
      if ((prefs.getString('firstName') ?? '').isNotEmpty) filledFields++;
      if ((prefs.getString('lastName') ?? '').isNotEmpty) filledFields++;
      if ((prefs.getString('gender') ?? '').isNotEmpty) filledFields++;
      if ((prefs.getString('dateOfBirth') ?? '').isNotEmpty) filledFields++;

      // Contact information fields (3)
      if ((prefs.getString('email') ?? '').isNotEmpty) filledFields++;
      if ((prefs.getString('phone') ?? '').isNotEmpty) filledFields++;
      if ((prefs.getString('address') ?? '').isNotEmpty) filledFields++;

      // Additional information fields (2)
      if ((prefs.getString('matricNumber') ?? '').isNotEmpty) filledFields++;
      if ((prefs.getString('occupation') ?? '').isNotEmpty) filledFields++;

      // Profile picture (1)
      if (prefs.getString('profileImagePath') != null) filledFields++;

      // Emergency contacts (3) - each contact counts as one field
      final contactsJson = prefs.getStringList('emergencyContacts') ?? [];
      filledFields += contactsJson.length > 3 ? 3 : contactsJson.length;

      // Update progress
      setState(() {
        _profileProgress = filledFields / totalFields;
      });
    });

    return _profileProgress; // Return current value while async operation completes
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalMargin = screenWidth * 0.04;
    final verticalMargin = 7.5;
    final contentPadding = screenWidth * 0.025;

    return Scaffold(
      backgroundColor: colors4Liontent.pagegrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: colors4Liontent.primary,
                padding: EdgeInsets.all(contentPadding + 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : null,
                              child:
                                  _profileImage == null
                                      ? Text(
                                        userName.isNotEmpty
                                            ? userName[0].toUpperCase()
                                            : "U",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: colors4Liontent.primary,
                                        ),
                                      )
                                      : null,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Hi, $userName",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                            ),
                            Stack(
                              children: [
                                Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                ),
                                Positioned(
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // lengthButton1White(
                    //   navigateTo: () {},
                    //   widgetchoice: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text('No Credits or Vouchers yet'),
                    //       Text('₦ 0'),
                    _tile(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No Credits or Vouchers',
                            overflow: TextOverflow.ellipsis,
                          ),

                          Row(
                            children: [
                              Text('\u20a6 0'),
                              Icon(Icons.chevron_right),
                            ],
                          ),
                        ],
                      ),
                      () {},
                    ),
                  ],
                ),
              ),
              _sectionCard(
                margin: horizontalMargin,
                padding: contentPadding,
                title: 'Complete your profile',
                subtitle:
                    'Complete your profile so as to make your next booking easier',

                buttonWidget: shortButton1Light(
                  widgetchoice: Container(
                    decoration: BoxDecoration(color: colors4Liontent.primary),
                    child: Text(
                      'Complete now',
                      style: TextStyle(color: colors4Liontent.secondary),
                    ),
                  ),
                  navigateTo: () async {
                    // Navigate to profile completion page and await result
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => completeUserProfile(),
                      ),
                    );

                    // If profile was updated, refresh the data
                    if (result == true) {
                      _loadUserData();
                      _calculateProfileProgress(); // Explicitly recalculate progress
                    }
                  },
                ),
              ),
              _sectionLabel('Manage my account', horizontalMargin),
              _settingsCard([
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.person_outlined),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Personal Details',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                  () {},
                ),
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(MdiIcons.databaseLock),
                      SizedBox(width: 7.5),

                      Expanded(
                        child: Text(
                          'Edit Security Settings',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
              ], horizontalMargin),
              _sectionLabel('Payment Information', horizontalMargin),
              _settingsCard([
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.wallet),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Saved Payment Methods',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.clockRotateLeft),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'View Past Transactions',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
              ], horizontalMargin),
              _sectionLabel('Help and Support', horizontalMargin),
              _settingsCard([
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FeatherIcons.phoneCall),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Contact Customer Support',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.handshake),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Dispute Resolution',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
              ], horizontalMargin),
              _sectionLabel('User Preferences', horizontalMargin),
              _settingsCard([
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.invert_colors),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Theme Settings',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.edit_notifications),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Notification Settings',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
              ], horizontalMargin),
              _sectionLabel('Partnership Programs', horizontalMargin),
              _settingsCard([
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(MdiIcons.domainPlus),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Host your property',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
              ], horizontalMargin),
              _sectionLabel('Legal and Privacy', horizontalMargin),
              _settingsCard([
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.scroll),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Privacy Policy',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
                _tile(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.fileShield),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Terms of conditions',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
                _tile(
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.bookOpen),
                      SizedBox(width: 7.5),
                      Expanded(
                        child: Text(
                          'Guidelines and Best Practices',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  () {},
                ),
              ], horizontalMargin),
              // _settingsCard([
              //   _tile(LineIcons.handshake, 'Host your property'),
              //   _tile(Text('data'), (){}),
              // ], horizontalMargin),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text, double margin) => Container(
    margin: EdgeInsets.symmetric(horizontal: margin, vertical: 7.5),
    child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _settingsCard(List<Widget> tiles, double margin) => Container(
    margin: EdgeInsets.symmetric(horizontal: margin, vertical: 7.5),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      children: List.generate(
        tiles.length * 2 - 1,
        (index) => index.isEven ? tiles[index ~/ 2] : Divider(height: 0),
      ),
    ),
  );

  Widget _tile(Widget widgetchoice, VoidCallback navigateTo) {
    return TextButton(
      onPressed: navigateTo,
      child: widgetchoice,
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
  // => lengthButton1White(
  //   navigateTo: () {},
  //   widgetchoice: Row(
  //     children: [
  //       Icon(icon),
  //       SizedBox(width: 7.5),
  //       Expanded(child: Text(title, overflow: TextOverflow.ellipsis)),
  //       Icon(Icons.chevron_right_outlined),
  //     ],
  //   ),
  // );

  Widget _sectionCard({
    required double margin,
    required double padding,
    required String title,
    required String subtitle,

    required Widget buttonWidget,
  }) => Container(
    margin: EdgeInsets.only(top: 15, bottom: 7.5, left: margin, right: margin),
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.white),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(subtitle, overflow: TextOverflow.ellipsis, maxLines: 2),
                ],
              ),
            ),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: CustomPaint(
                painter: ProfileProgressPainter(
                  progress: _profileProgress,
                  progressColor: colors4Liontent.primary,
                  backgroundColor: Colors.grey[200]!,
                ),
                child: Center(
                  child: Text(
                    "${(_profileProgress * 100).toInt()}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colors4Liontent.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        // shortButton1Light(
        //   widgetchoice: Container(
        //     decoration: BoxDecoration(color: colors4Liontent.primary),
        //     child: Text(
        //       buttonText,
        //       style: TextStyle(color: colors4Liontent.secondary),
        //     ),
        //   ),
        //   navigateTo: () {},
        // ),
        buttonWidget,
      ],
    ),
  );
}
