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

class usersProfile extends StatelessWidget {
  const usersProfile({super.key});

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
                            CircleAvatar(child: Text("F")),
                            SizedBox(width: 10),
                            Text(
                              "Hi, Alonzo",
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
                  navigateTo: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => completeUserProfile(),
                      ),
                    );
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
            Container(height: 80, width: 80, color: colors4Liontent.primary),
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
