import '../api.dart';
import '../components/text.dart';
import '../object.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PageSequence extends StatefulWidget {
  const PageSequence({super.key, required this.isMobile});

  final bool isMobile;

  @override
  State<PageSequence> createState() => _PageSequenceState();
}

class _PageSequenceState extends State<PageSequence> with TickerProviderStateMixin {
  bool sequenceOpenAdvanced = false;
  int indexSequenceAlgo = 0;
  int indexSequenceInputMethod = 0;
  String sequenceFileName = "Please select file";
  TextEditingController querySeq = TextEditingController();
  TextEditingController queryChain = TextEditingController();
  List<Algorithm> algorithmSequences = [
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
                    child: text(algorithmSequences[indexSequenceAlgo].name, 15.sp, Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: algorithmSequences.map((algo) {
                      int indexOfAlgo = algorithmSequences.indexOf(algo);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            indexSequenceAlgo = indexOfAlgo;
                          });
                        },
                        child: Container(
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: indexSequenceAlgo == indexOfAlgo ? Colors.purple : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: text(algo.alias, 13.sp, indexSequenceAlgo == indexOfAlgo ? Colors.white : Colors.purple),
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
                                        indexSequenceInputMethod = 0;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        indexSequenceInputMethod == 0 ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
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
                                        indexSequenceInputMethod = 1;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        indexSequenceInputMethod == 1 ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
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
                                            label: text(sequenceFileName, 12.sp, Colors.black),
                                            onPressed: () async {
                                              await uploadFileSequence().then((value) {
                                                setState(() {
                                                  if (value.isNotEmpty) {
                                                    sequenceFileName = value;
                                                  } else {
                                                    sequenceFileName = "Please select file";
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
                          children: algorithmSequences[indexSequenceAlgo].engines.map((e) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    for (var engine in algorithmSequences[indexSequenceAlgo].engines) {
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
                          itemCount: algorithmSequences[indexSequenceAlgo].databases.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        for (var db in algorithmSequences[indexSequenceAlgo].databases) {
                                          db.selected = false;
                                        }
                                        algorithmSequences[indexSequenceAlgo].databases[index].selected = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        algorithmSequences[indexSequenceAlgo].databases[index].selected
                                            ? const Icon(Icons.check_box)
                                            : const Icon(Icons.check_box_outline_blank),
                                        const SizedBox(width: 5),
                                        text(algorithmSequences[indexSequenceAlgo].databases[index].name, 13.sp, Colors.black),
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
                        sequenceOpenAdvanced = !sequenceOpenAdvanced;
                      });
                    },
                    icon: Icon(Icons.settings, color: Colors.white, size: 15.sp),
                    label: text(sequenceOpenAdvanced ? "Hide advanced options" : "Show advanced options", 13.sp, Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                if (sequenceOpenAdvanced)
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: algorithmSequences[indexSequenceAlgo].databases.length,
                            itemBuilder: (context, index) {
                              return const Row();
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
