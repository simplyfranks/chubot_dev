import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';

class normalTextField extends StatelessWidget {
  final String labelHint;
  const normalTextField({super.key, required this.labelHint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors4Liontent.primary, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        labelText: labelHint,
        labelStyle: TextStyle(color: colors4Liontent.primary),
      ),
      cursorColor: colors4Liontent.primary,
    );
  }
}
