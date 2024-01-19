import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget md(String textData) {
  return Markdown(
    shrinkWrap: true,
    selectable: true,
    padding: EdgeInsets.zero,
    onTapLink: (text, targetUrl, title) {
      launchUrl(Uri.parse(targetUrl ?? "chrome://new-tab-page"));
    },
    data: textData,
  );
}
