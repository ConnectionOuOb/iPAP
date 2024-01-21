import '../components/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget footer() {
  return Wrap(
    alignment: WrapAlignment.center,
    runAlignment: WrapAlignment.center,
    children: [
      text("© 2024 - ", 18, Colors.white),
      InkWell(
        onTap: () async => await launchUrl(Uri.parse('https://github.com/Connection2Peter')),
        child: text("Connection", 18, Colors.cyan),
      ),
      text(", Powered by ", 18, Colors.white),
      InkWell(
        onTap: () async => await launchUrl(Uri.parse('http://10.life.nctu.edu.tw/')),
        child: text("10Lab", 18, Colors.cyan),
      ),
      SizedBox(width: 2.w),
      InkWell(
        onTap: () async => await launchUrl(Uri.parse('https://www.nycu.edu.tw/')),
        child: text("National Yang Ming Chiao Tung University", 18, Colors.cyan),
      ),
      text(", Taiwan, Roc", 18, Colors.white),
    ],
  );
}
