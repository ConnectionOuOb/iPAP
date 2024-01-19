import '../components/text.dart';
import '../illustrate/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PageTutorial extends StatefulWidget {
  const PageTutorial({super.key, required this.isMobile});

  final bool isMobile;

  @override
  State<PageTutorial> createState() => _PageTutorialState();
}

class _PageTutorialState extends State<PageTutorial> with TickerProviderStateMixin {
  ItemScrollController mdScroll = ItemScrollController();
  ItemPositionsListener mdPosition = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tutorialTexts.length,
              itemBuilder: (context, index) {
                String showText = "  ${"    " * tutorialTexts[index].stage}${tutorialTexts[index].name}";
                return InkWell(
                  onTap: () {
                    mdScroll.scrollTo(
                      index: index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: tutorialTexts[index].onRead ? Colors.purple : Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: text(showText, 12.sp, tutorialTexts[index].onRead ? Colors.white : Colors.black),
                  ),
                );
              },
            ),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 4,
          child: ScrollablePositionedList.builder(
            itemScrollController: mdScroll,
            itemPositionsListener: mdPosition,
            itemCount: tutorialTexts.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(widget.isMobile ? 20 : 40, 30, 0, 0),
                    alignment: Alignment.bottomLeft,
                    child: text(tutorialTexts[index].name, 15.sp, Colors.black, weight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 1,
                    indent: widget.isMobile ? 20 : 40,
                    endIndent: widget.isMobile ? 20 : 40,
                    color: Colors.purple,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 20 : 40, vertical: 20),
                    child: tutorialTexts[index].content,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
