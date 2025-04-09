import 'dart:async';
import 'package:flutter/material.dart';

import 'package:liontent/core/constants/colors.dart';
import 'package:liontent/core/utils/user_preference.dart';
import 'package:liontent/features/authPage.dart';
import 'package:liontent/features/privacypolicy.dart';
import 'package:liontent/features/splash/loadingboxes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class introSplash extends StatefulWidget {
  const introSplash({super.key});

  @override
  State<introSplash> createState() => _introSplashState();
}

class _introSplashState extends State<introSplash> {
  bool hasConnected = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivityWithTimeout();
  }

  void _checkConnectivityWithTimeout() async {
    final Completer<void> completer = Completer<void>();
    StreamSubscription? subscription;

    // 🔍 Check if actual internet is available
    final bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (hasInternet) {
      hasConnected = true;
      bool isFirstTime = await currentUserPreference.isFirstTimeUser();
      await Future.delayed(const Duration(seconds: 6));
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    isFirstTime
                        ? const privacyWriteup() // <- Replace with your screen
                        : const authenticate(),
          ),
        );
      }
      await currentUserPreference.setFirstTimeFalse();
      completer.complete();
      return;
    }

    // 🔁 Listen for internet connection changes
    subscription = InternetConnectionChecker().onStatusChange.listen((
      status,
    ) async {
      if (status == InternetConnectionStatus.connected && !hasConnected) {
        hasConnected = true;
        subscription?.cancel();
        bool isFirstTime = await currentUserPreference.isFirstTimeUser();
        await Future.delayed(const Duration(seconds: 8));
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      isFirstTime
                          ? const privacyWriteup()
                          : const authenticate(),
            ),
          );
        }

        await currentUserPreference.setFirstTimeFalse();
        completer.complete();
      }
    });

    // ⏳ Timeout fallback
    Future.delayed(const Duration(seconds: 45)).then((_) async {
      if (!hasConnected) {
        subscription?.cancel();
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const fallBackforSplash()),
          );
        }
        completer.complete();
      }
    });

    await completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff1c6f0f),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [ShimmerText(), SizedBox(height: 30), LoadingBoxes()],
        ),
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  const ShimmerText({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: colors4Liontent.primaryLight,
      period: const Duration(seconds: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'Lion',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),

            TextSpan(
              text: 'tent',
              style: TextStyle(
                fontSize: 40,
                foreground:
                    Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 0.6
                      ..color = Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
