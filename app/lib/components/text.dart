import 'package:flutter/material.dart';

Widget text(String text, double size, Color color, {FontWeight weight = FontWeight.normal}) {
  return Text(
    text,
    overflow: TextOverflow.fade,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
    ),
  );
}

Widget textSelect(String text, double size, Color color, {FontWeight weight = FontWeight.normal}) {
  return SelectableText(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
    ),
  );
}

Widget firstAlphaHL(String input, double size) {
  return Row(
    children: [
      text(input.substring(0, 1), size, Colors.redAccent, weight: FontWeight.bold),
      text(input.substring(1), size, Colors.black),
    ],
  );
}
