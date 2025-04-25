import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white, size: 20),
          title: Text(
            'View Transaction History',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: colors4Liontent.primary,
        ),
      ),
    );
  }
}
