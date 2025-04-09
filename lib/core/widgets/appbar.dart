import 'package:flutter/material.dart';
import 'package:liontent/core/constants/colors.dart';

PreferredSize customAppBar1({required VoidCallback closeOpera}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: Container(
      child: Row(
        children: [
          IconButton(
            onPressed: closeOpera,
            icon: const Icon(Icons.close, color: Colors.white, size: 25),
          ),
          Expanded(child: SizedBox(), flex: 2),
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(text: 'Lion', style: TextStyle(color: Colors.white)),

                  TextSpan(
                    text: 'tent',
                    style: TextStyle(
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
          ),
          Expanded(child: SizedBox(), flex: 3),
        ],
      ),
      decoration: BoxDecoration(
        color: colors4Liontent.primary,
        /*border: Border(bottom: BorderSide(color: Colors.black, width: 0.5), ),*/ boxShadow:
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
      ),
    ),
  );
}
