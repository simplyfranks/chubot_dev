import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/appbar.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liontent/features/authentication/continue_email.dart';

class authenticate extends StatelessWidget {
  const authenticate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(closeOpera: () {}),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login and get personalised searches \njust for you\n',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            lengthButton1Light(
              navigateTo: () {},
              widgetchoice: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.google,
                      color: colors4Liontent.secondary,
                      size: 20,
                    ),
                    Text(
                      ' Continue with Google',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            lengthButton1TranspOutline(
              navigateTo: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => contEmail()),
                );
              },
              widgetchoice: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail_outline,
                      color: colors4Liontent.primary,
                      size: 20,
                    ),
                    Text(
                      ' Continue with Mail',
                      style: TextStyle(
                        color: colors4Liontent.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        "By continuing, you agree to our ",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Terms of Service",
                          style: TextStyle(
                            color: Color(0xff1c6f0f),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text("and ", style: TextStyle(fontSize: 16)),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Privacy Statement.",
                          style: TextStyle(
                            color: Color(0xff1c6f0f),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
