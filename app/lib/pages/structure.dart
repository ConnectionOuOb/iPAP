import '../api.dart';
import '../object.dart';
import '../components/text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageStructure extends StatefulWidget {
  const PageStructure({super.key, required this.isMobile});

  final bool isMobile;

  @override
  State<PageStructure> createState() => _PageStructureState();
}

class _PageStructureState extends State<PageStructure> with TickerProviderStateMixin {
  bool structureOpenAdvanced = false;
  int indexStructureAlgo = 0;
  int indexStructureInputMethod = 0;
  String structureFileName = "Please select file";
  TextEditingController queryStructure = TextEditingController();
  TextEditingController queryChain = TextEditingController();
  List<Algorithm> algorithmStructures = [
    Algorithm(
      "AlphaFold2",
      "Alphabet Google DeepMind AlphaFold2",
      [
        SelectItem(true, "aaa"),
        SelectItem(false, "bbb"),
      ],
      [
        SelectItem(true, "ccc"),
        SelectItem(false, "ddd"),
        SelectItem(false, "eee"),
      ],
    ),
    Algorithm(
      "TM-align",
      "A protein structure alignment algorithm based on the TM-score",
      [
        SelectItem(true, "fff"),
        SelectItem(false, "ggg"),
      ],
      [
        SelectItem(true, "hhh"),
        SelectItem(false, "iii"),
        SelectItem(false, "jjj"),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 15.h,
            margin: EdgeInsets.symmetric(horizontal: widget.isMobile ? 10.w : 15.w),
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
                    child: text(algorithmStructures[indexStructureAlgo].name, 15.sp, Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: algorithmStructures.map((algo) {
                      int indexOfAlgo = algorithmStructures.indexOf(algo);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            indexStructureAlgo = indexOfAlgo;
                          });
                        },
                        child: Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: indexStructureAlgo == indexOfAlgo ? Colors.purple : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: text(algo.alias, 13.sp, indexStructureAlgo == indexOfAlgo ? Colors.white : Colors.purple),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 10.w : 15.w),
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  flex: widget.isMobile ? 2 : 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        indexStructureInputMethod = 0;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        indexStructureInputMethod == 0 ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
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
                                      controller: queryStructure,
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
                                        indexStructureInputMethod = 1;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        indexStructureInputMethod == 1 ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
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
                                        flex: widget.isMobile ? 1 : 2,
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton.icon(
                                            label: text(structureFileName, 12.sp, Colors.black),
                                            onPressed: () async {
                                              await uploadFileStructure().then((value) {
                                                setState(() {
                                                  if (value.isNotEmpty) {
                                                    structureFileName = value;
                                                  } else {
                                                    structureFileName = "Please select file";
                                                  }
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
                                Expanded(flex: widget.isMobile ? 0 : 2, child: const SizedBox()),
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          children: algorithmStructures[indexStructureAlgo].engines.map((e) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    for (var engine in algorithmStructures[indexStructureAlgo].engines) {
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          itemCount: algorithmStructures[indexStructureAlgo].databases.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        for (var db in algorithmStructures[indexStructureAlgo].databases) {
                                          db.selected = false;
                                        }
                                        algorithmStructures[indexStructureAlgo].databases[index].selected = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        algorithmStructures[indexStructureAlgo].databases[index].selected
                                            ? const Icon(Icons.check_box)
                                            : const Icon(Icons.check_box_outline_blank),
                                        const SizedBox(width: 5),
                                        text(algorithmStructures[indexStructureAlgo].databases[index].name, 13.sp, Colors.black),
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
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    border: Border.all(color: Colors.deepPurpleAccent, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        structureOpenAdvanced = !structureOpenAdvanced;
                      });
                    },
                    icon: Icon(Icons.settings, color: Colors.white, size: 15.sp),
                    label: text(structureOpenAdvanced ? "Hide advanced options" : "Show advanced options", 13.sp, Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                if (structureOpenAdvanced)
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text("Advance option", 13.sp, Colors.white),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          constraints: BoxConstraints(minHeight: 1.h, maxHeight: 30.h),
                          child: const Row(),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(Icons.file_upload_outlined, color: Colors.black, size: 15.sp),
                    label: text("Submit", 15.sp, Colors.black),
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
}
