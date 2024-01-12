import 'config.dart';
import 'object.dart';
import 'Pages/home.dart';
import 'pages/result.dart';
import 'Pages/contact.dart';
import 'Pages/tutorial.dart';
import 'Pages/sequence.dart';
import 'Pages/structure.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const IpapApp());
}

class IpapApp extends StatelessWidget {
  const IpapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'iPAP',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
          home: const Ipap(),
        );
      },
    );
  }
}

class Ipap extends StatefulWidget {
  const Ipap({super.key});

  @override
  State<Ipap> createState() => _IpapState();
}

class _IpapState extends State<Ipap> with TickerProviderStateMixin {
  bool isMobile = false;
  String sessionID = "";
  TextEditingController searchSession = TextEditingController();

  List<IconText> tabNames = [
    IconText(false, "Home", Icons.home, []),
    IconText(false, "Sequence", Icons.arrow_drop_down, ["SARST2", "GoBLAST"]),
    IconText(false, "Structure", Icons.arrow_drop_down, ["SARST2", "GoBLAST"]),
    IconText(false, "Tutorial", Icons.library_books, []),
    IconText(false, "Contact", Icons.contacts, []),
    IconText(false, "", Icons.abc, []),
  ];

  late TabController tabController;

  @override
  void initState() {
    Uri uri = Uri.parse(html.window.location.href);
    sessionID = uri.queryParameters['sID'] ?? '';

    tabController = TabController(
      initialIndex: sessionID == "" ? 0 : 5,
      length: tabNames.length,
      vsync: this,
      animationDuration: Duration.zero,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    isMobile = screenSize.width < 1000;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          titleSpacing: 0,
          leadingWidth: 8.w,
          leading: InkWell(
            onTap: () {
              setState(() {
                tabController.index = 0;
              });
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '𝒊𝑷𝑨𝑷',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          title: TabBar(
            controller: tabController,
            isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            indicatorColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            labelPadding: EdgeInsets.zero,
            dividerColor: Colors.transparent,
            tabs: tabNames.map((e) {
              return e.name == ""
                  ? const SizedBox()
                  : Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isMobile) text(e.name, 12.sp, Colors.black, weight: FontWeight.bold),
                            const SizedBox(width: 5),
                            if (e.icon != null) Icon(e.icon, size: isMobile ? 17.sp : 14.sp),
                          ],
                        ),
                      ),
                    );
            }).toList(),
          ),
          actions: [
            SizedBox(
              width: isMobile ? 30.w : 20.w,
              height: 40,
              child: TextField(
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Search session',
                ),
                controller: searchSession,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.black,
            ),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            PageHome(isMobile: isMobile),
            PageSequence(isMobile: isMobile),
            PageStructure(isMobile: isMobile),
            PageTutorial(isMobile: isMobile),
            PageContact(isMobile: isMobile),
            PageResult(isMobile: isMobile, sessionID: sessionID),
          ],
        ),
        bottomNavigationBar: Container(
          height: isMobile ? 100 : 50,
          color: Colors.black,
          child: isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    footerTestStyle(footerText1),
                    const SizedBox(height: 10),
                    footerTestStyle(footerText2),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    footerTestStyle(footerText1),
                    const SizedBox(width: 20),
                    footerTestStyle(footerText2),
                  ],
                ),
        ),
      ),
    );
  }
}
