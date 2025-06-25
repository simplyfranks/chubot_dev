import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/widgets/appbar.dart';
import 'package:liontent/core/widgets/buttons.dart';
import 'package:liontent/features/landing/landing_search.dart';

class usersBooked extends StatelessWidget {
  const usersBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(bartitle: 'Booked'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              'Save what you like for later',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 15),
            Text(
              'You can create a list of your favourite items \nso you can visit them later',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            shortButton1Light(
              widgetchoice: Text(
                'Go to search',
                style: TextStyle(color: colors4Liontent.secondary),
              ),
              navigateTo: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => landingPageSearch()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
