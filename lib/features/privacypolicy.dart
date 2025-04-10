import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/constants/loaderpages/demospinner.dart';
import 'package:liontent/core/widgets/appbar.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:liontent/features/authentication/authPage.dart';

class privacyWriteup extends StatelessWidget {
  const privacyWriteup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(
        closeOpera: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => const demospinner(
                    pageColor: Color(0xff1c6f0f),
                    spinnerColor: colors4Liontent.secondary,
                    objectColor: colors4Liontent.primaryLight,
                  ),
            ),
          );
        },
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: colors4Liontent.primary),
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 18, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We suggest turning on notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: colors4Liontent.secondary,
                ),
              ),
              Text(
                '\nEnable notifications to get real time listings \nand reminders from Liontent. Stay ahead of others \nand never miss out on listings, promotion, \nrewards and other info about Liontent\'s product and services.',
                style: TextStyle(
                  fontSize: 16,
                  color: colors4Liontent.secondary,
                ),
              ),

              Text(
                '\n\nYou can always turn it off in the settings\n',
                style: TextStyle(
                  fontSize: 16,
                  color: colors4Liontent.secondary,
                ),
              ),
              Divider(thickness: 2),
              TextButton(
                onPressed: null,
                child: Row(
                  children: [
                    Text(
                      'Read the privacy and policy statement',
                      style: TextStyle(
                        fontSize: 16,
                        color: colors4Liontent.secondary,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: colors4Liontent.secondary,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2),
              Expanded(child: SizedBox()),
              lengthButton1Light(
                navigateTo: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const demospinner(
                            pageColor: Color(0xff1c6f0f),
                            spinnerColor: colors4Liontent.secondary,
                            objectColor: colors4Liontent.primaryLight,
                          ),
                    ),
                  );
                },
                widgetchoice: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    color: colors4Liontent.secondary,
                  ),
                ),
              ),
              lengthButton1Transp(
                navigateTo: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const demospinner(
                            pageColor: Color(0xff1c6f0f),
                            spinnerColor: colors4Liontent.secondary,
                            objectColor: colors4Liontent.primaryLight,
                          ),
                    ),
                  );
                },
                widgetchoice: Text(
                  'Not now',
                  style: TextStyle(
                    fontSize: 16,
                    color: colors4Liontent.secondary,
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
