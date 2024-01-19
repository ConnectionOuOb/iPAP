import '../components/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageContact extends StatefulWidget {
  const PageContact({super.key, required this.isMobile});

  final bool isMobile;

  @override
  State<PageContact> createState() => _PageContactState();
}

class _PageContactState extends State<PageContact> with TickerProviderStateMixin {
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
                text("Contact Information", 20.sp, Colors.black),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 10.w : 15.w),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(flex: 1, child: Icon(Icons.mail, size: 20.sp)),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        child: text("connection.bt12@nycu.edu.tw", 20.sp, Colors.black),
                        onTap: () async => await launchUrl(Uri.parse('mailto:connection.bt12@nycu.edu.tw')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Row(
                  children: [
                    Expanded(flex: 1, child: Icon(Icons.phone, size: 20.sp)),
                    Expanded(
                      flex: 3,
                      child: textSelect("+886 03-5712121 ext: 56923", 20.sp, Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Row(
                  children: [
                    Expanded(flex: 1, child: Icon(Icons.house, size: 20.sp)),
                    Expanded(
                      flex: 3,
                      child: textSelect("BioICT Building 401, No. 75,\nBo-Ai St., Hsinchu 300, Taiwan", 20.sp, Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
