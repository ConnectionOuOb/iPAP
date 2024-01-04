import 'config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TabItem {
  String name;
  IconData? icon;

  TabItem(this.name, this.icon);
}

void main() {
  runApp(const IPAP());
}

class IPAP extends StatelessWidget {
  const IPAP({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'iPAP',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  bool isMobile = false;
  TextEditingController searchSession = TextEditingController();
  List<TabItem> tabNames = [
    TabItem("Home", Icons.home),
    TabItem("Sequence", Icons.arrow_downward),
    TabItem("Structure", Icons.arrow_downward),
    TabItem("Contact", Icons.contacts),
  ];
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: tabNames.length, vsync: this);
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
          leadingWidth: 13.w,
          leading: Container(
            alignment: Alignment.center,
            child: Text(
              ' 𝒊 𝑷 𝑨 𝑷',
              style: TextStyle(
                fontSize: isMobile ? 20 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
              return Container(
                width: isMobile ? 8.w : 12.w,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isMobile) text(e.name, 18, Colors.black, weight: FontWeight.bold),
                      const SizedBox(width: 5),
                      if (e.icon != null) Icon(e.icon, size: 20),
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
            mainPage(),
            sequence(),
            sequence(),
            sequence(),
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

  Widget mainPage() {
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
            indent: isMobile ? 10.w : 15.w,
            endIndent: isMobile ? 10.w : 15.w,
            color: Colors.purple,
          ),
        ],
        
      ),
    );
  }

  Widget sequence() {
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
            indent: isMobile ? 10.w : 15.w,
            endIndent: isMobile ? 10.w : 15.w,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
