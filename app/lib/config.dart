import 'package:flutter/material.dart';

// # Footer
String footerText1 = "© 2024 - All rights reserved by Connection";
String footerText2 = "National Yang Ming Chiao Tung University, Taiwan, Roc";

Widget footerTestStyle(String input) {
  return text(input, 18, Colors.white);
}

// # Text
Widget text(String text, double size, Color color, {FontWeight weight = FontWeight.normal}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
    ),
  );
}
