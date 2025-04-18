import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/features/authentication/continue_email.dart';
import 'package:liontent/features/landing/landing_search.dart';
import 'package:liontent/features/landing/searchTab.dart';
import 'package:liontent/features/landing/searchtabs/properties.dart';

import 'package:liontent/features/privacypolicy.dart';
import 'package:liontent/features/splash/splashscreen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const liontent());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: colors4Liontent.primary,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class liontent extends StatelessWidget {
  const liontent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: landingPageSearch(),
      ),
    );
  }
}
