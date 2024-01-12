import '../config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageResult extends StatefulWidget {
  const PageResult({super.key, required this.isMobile});

  final bool isMobile;

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
        SizedBox(height: 5.h),
        text('computing', 20.sp, Colors.black, weight: FontWeight.bold),
        SizedBox(height: 5.h),
      ],
    );
  }

  Widget result() {
    return Column(
      children: [
        SizedBox(height: 5.h),
        text('Result', 20.sp, Colors.black, weight: FontWeight.bold),
        SizedBox(height: 5.h),
      ],
    );
  }
}
