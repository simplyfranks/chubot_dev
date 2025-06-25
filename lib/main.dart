import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/features/authentication/continue_email.dart';
import 'package:liontent/features/landing/landing_search.dart';
import 'package:liontent/features/landing/profileTab/userDetails.dart';
import 'package:liontent/features/landing/profileTab/user_security.dart';
import 'package:liontent/features/landing/searchtabs/lodgesTab/lodgeCardCont.dart';

import 'package:liontent/features/landing/searchtabs/searchTab.dart';
import 'package:liontent/features/landing/searchtabs/properties.dart';

import 'package:liontent/features/privacypolicy.dart';
import 'package:liontent/features/splash/splashscreen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: colors4Liontent.primary,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LodgeDetailsPage(
          lodgeName: 'kenechukwu lodge',
          leadingImgUrl: '',
        ),
      ),
    );
  }
}
