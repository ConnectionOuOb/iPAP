import 'api.dart';
import 'config.dart';
import 'object.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
  int indexSeqAlgo = 0;
  int indexSeqInputMethod = 0;
  bool isMobile = false;
  String fileNameSeq = "Please select file";
  TextEditingController searchSession = TextEditingController();

  List<IconText> tabNames = [
    IconText("Home", Icons.home),
    IconText("Sequence", Icons.arrow_downward),
    IconText("Structure", Icons.arrow_downward),
    IconText("Contact", Icons.contacts),
  ];
  List<Algorithm> algorithms = [
    Algorithm(
      "BLAST",
      "Basic Local Alignment Search Tool",
      [
        SelectItem(true, "111"),
        SelectItem(false, "222"),
      ],
      [
        SelectItem(true, "333"),
        SelectItem(false, "444"),
        SelectItem(false, "555"),
      ],
    ),
    Algorithm(
      "SSE-PSSM",
      "Secondary Structure Element-based Position Specific Scoring Matrix",
      [
        SelectItem(true, "666"),
        SelectItem(false, "777"),
      ],
      [
        SelectItem(true, "888"),
        SelectItem(false, "999"),
        SelectItem(false, "000"),
      ],
    ),
  ];

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: tabNames.length,
      vsync: this,
      animationDuration: Duration.zero,
      initialIndex: 1,
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
            mainPage(),
            sequence(),
            structure(),
            contact(),
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
          const SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.w : 15.w),
            child: textSelect(
              "  This platform seamlessly integrates sequence analysis tools "
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
              "technologies converge for a comprehensive and seamless analysis experience.",
              14.sp,
              Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget sequence() {
    TextEditingController querySeq = TextEditingController();
    TextEditingController queryChain = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 15.h,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 10.w : 15.w),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.purple, width: 1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: text(algorithms[indexSeqAlgo].name, 15.sp, Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: algorithms.map((algo) {
                      int indexOfAlgo = algorithms.indexOf(algo);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            indexSeqAlgo = indexOfAlgo;
                          });
                        },
                        child: Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: indexSeqAlgo == indexOfAlgo ? Colors.purple : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: text(algo.alias, 13.sp, indexSeqAlgo == indexOfAlgo ? Colors.white : Colors.purple),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.w : 15.w),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.purple, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.purple,
                        height: 6.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            text("Query", 12.5.sp, Colors.white),
                            text("Step (1/3)  ", 12.5.sp, Colors.white),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: isMobile ? 2 : 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexSeqInputMethod = 0;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        indexSeqInputMethod == 0 ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                                        const SizedBox(width: 5),
                                        text("Sequence", 13.sp, Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller: querySeq,
                                      minLines: 1,
                                      maxLines: 1000,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintText: 'Enter protein sequence',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexSeqInputMethod = 1;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        indexSeqInputMethod == 1 ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                                        const SizedBox(width: 5),
                                        text("Upload file", 13.sp, Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: isMobile ? 1 : 2,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton.icon(
                                            label: text(fileNameSeq, 12.sp, Colors.black),
                                            onPressed: () async {
                                              await uploadFile().then((value) {
                                                setState(() {
                                                  fileNameSeq = value;
                                                });
                                              });
                                            },
                                            icon: const Icon(Icons.upload_file),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            text("Chain :", 12.sp, Colors.black),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              flex: 1,
                                              child: TextField(
                                                controller: queryChain,
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  contentPadding: EdgeInsets.all(10.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(flex: isMobile ? 0 : 2, child: const SizedBox()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.purple, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.purple,
                        height: 6.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            text("Refinement engine", 12.5.sp, Colors.white),
                            text("Step (2/3)  ", 12.5.sp, Colors.white),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        height: 10.h,
                        child: Row(
                          children: algorithms[indexSeqAlgo].engines.map((e) {
                            return Expanded(child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    for (var engine in algorithms[indexSeqAlgo].engines) {
                                      engine.selected = false;
                                    }
                                    e.selected = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    e.selected ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                                    const SizedBox(width: 5),
                                    text(e.name, 13.sp, Colors.black),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.purple, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.purple,
                        height: 6.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            text("Target database", 12.5.sp, Colors.white),
                            text("Step (3/3)  ", 12.5.sp, Colors.white),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        constraints: BoxConstraints(minHeight: 1.h, maxHeight: 30.h),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: algorithms[indexSeqAlgo].databases.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        for (var db in algorithms[indexSeqAlgo].databases) {
                                          db.selected = false;
                                        }
                                        algorithms[indexSeqAlgo].databases[index].selected = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        algorithms[indexSeqAlgo].databases[index].selected ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                                        const SizedBox(width: 5),
                                        text(algorithms[indexSeqAlgo].databases[index].name, 13.sp, Colors.black),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget structure() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            indent: isMobile ? 10.w : 15.w,
            endIndent: isMobile ? 10.w : 15.w,
            color: Colors.purple,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.w : 15.w),
            child: const Text("123"),
          ),
        ],
      ),
    );
  }

  Widget contact() {
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
            indent: isMobile ? 10.w : 15.w,
            endIndent: isMobile ? 10.w : 15.w,
            color: Colors.purple,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.w : 15.w),
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
