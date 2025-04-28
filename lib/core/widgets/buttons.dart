import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';

class lengthButton1Light extends StatelessWidget {
  final VoidCallback navigateTo;
  final Widget widgetchoice;

  const lengthButton1Light({
    super.key,
    required this.navigateTo,
    required this.widgetchoice,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: navigateTo,
      child: Center(
        child: widgetchoice,
        // child: Text(
        //   buttonTitle,
        //   style: TextStyle(fontSize: 16, color: colors4Liontent.secondary),
        // ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: colors4Liontent.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
    );
  }
}

class lengthButton1Transp extends StatelessWidget {
  final VoidCallback navigateTo;
  final Widget widgetchoice;

  const lengthButton1Transp({
    super.key,
    required this.navigateTo,
    required this.widgetchoice,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: navigateTo,
      child: Center(child: widgetchoice),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}

class lengthButton1TranspOutline extends StatelessWidget {
  final VoidCallback navigateTo;
  final Widget widgetchoice;

  const lengthButton1TranspOutline({
    super.key,
    required this.navigateTo,
    required this.widgetchoice,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: navigateTo,
      child: Center(child: widgetchoice),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colors4Liontent.primary, width: 1),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}

class shortButton1Light extends StatelessWidget {
  final Widget widgetchoice;
  final VoidCallback navigateTo;

  const shortButton1Light({
    super.key,
    required this.widgetchoice,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: navigateTo,
      child: widgetchoice,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors4Liontent.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}

class lengthButton1White extends StatelessWidget {
  final VoidCallback navigateTo;
  final Widget widgetchoice;

  const lengthButton1White({
    super.key,
    required this.navigateTo,
    required this.widgetchoice,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: navigateTo,
      child: Center(child: widgetchoice),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
