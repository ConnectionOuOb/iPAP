import '../config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key, required this.isMobile});

  final bool isMobile;

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                firstAlphaHL("integrated", 20.sp),
                const SizedBox(width: 20),
                firstAlphaHL("Protein", 20.sp),
                const SizedBox(width: 20),
                firstAlphaHL("Analysis", 20.sp),
                const SizedBox(width: 20),
                firstAlphaHL("Platform", 20.sp),
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            indent: widget.isMobile ? 10.w : 15.w,
            endIndent: widget.isMobile ? 10.w : 15.w,
            color: Colors.purple,
          ),
          const SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 10.w : 15.w),
            child: textSelect(statement, 14.sp, Colors.black),
          ),
        ],
      ),
    );
  }
}
