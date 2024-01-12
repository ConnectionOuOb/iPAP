import 'package:flutter/services.dart';

import '../config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageResult extends StatefulWidget {
  const PageResult({super.key, required this.isMobile, required this.sessionID});

  final bool isMobile;
  final String sessionID;

  @override
  State<PageResult> createState() => _PageResultState();
}

class _PageResultState extends State<PageResult> with TickerProviderStateMixin {
  bool endCompute = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 5.h),
          Container(
              margin: widget.isMobile ? EdgeInsets.symmetric(horizontal: 5.w) : EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: endCompute ? result() : computing()),
        ],
      ),
    );
  }

  Widget computing() {
    return Column(
      children: [
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text("Session ID : ", 16.sp, Colors.black),
                  textSelect(widget.sessionID, 16.sp, Colors.black, weight: FontWeight.bold),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: widget.sessionID));
                },
                icon: Icon(Icons.copy, size: 16.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget result() {
    return Column(
      children: [
        SizedBox(height: 5.h),
        Row(
          children: [
            text("result", 20.sp, Colors.black),
          ],
        ),
      ],
    );
  }
}
