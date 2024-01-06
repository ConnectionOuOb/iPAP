import 'package:flutter/material.dart';

//# Main page
Widget firstAlphaHL(String input, double size) {
  return Row(
    children: [
      text(input.substring(0, 1), size, Colors.redAccent, weight: FontWeight.bold),
      text(input.substring(1), size, Colors.black),
    ],
  );
}

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

// # Statement
String statement = "  This platform seamlessly integrates sequence analysis tools "
    "such as BLAST, Multiple Sequence Alignment (MSA), and Secondary "
    "Structure Prediction (SSP) to provide a robust foundation for "
    "understanding protein sequences. In addition to sequence analysis, "
    "our platform incorporates advanced structure analysis capabilities "
    "using state-of-the-art technologies like AlphaFold2 and TM-Align.\n\n"
    "  This integrated platform not only accelerates the research process but "
    "also ensures a holistic understanding of proteins, from their primary "
    "sequences to detailed structural characteristics. Researchers can leverage "
    "the power of diverse analytical tools within a unified environment, promoting "
    "efficiency and precision in protein analysis. Stay at the forefront of protein "
    "research with our Integrated Protein Analysis Platform, where cutting-edge "
    "technologies converge for a comprehensive and seamless analysis experience.";
