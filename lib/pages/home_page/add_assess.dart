import 'package:faith_assessment/model/const.dart';
import 'package:faith_assessment/preferences.dart';
import 'package:flutter/material.dart';
import '../../model/my_dialog.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'details_page.dart';

class AddAssess extends StatefulWidget {
  const AddAssess({super.key, required this.name, required this.data});
  final String name;
  final List data;
  @override
  State<AddAssess> createState() => _AddAssessState();
}

class _AddAssessState extends State<AddAssess> {
  List assessmentList = [];
  Map<String, dynamic> assessmentData = {};
  late List userData;
  String? dropValue;
  bool toAllCheck = false;
  late TextEditingController bottomSheetTextController;
  late GlobalKey<FormState> bottomSheetGlobalKey;
  List<dynamic> assessValue = [];
  List<bool> assessCheckValue = [];
  getData() async {
    userData = widget.data;
    var data = await MyPref().getAssessData();
    setState(() {
      assessmentList = data;
    });

    updateControllers();
  }

  updateControllers() {
    for (var item in assessmentList) {
      switch (item['type']) {
        case 'متن':
          {
            assessValue.add(TextEditingController());
          }
        case 'چک باکس':
          {
            assessValue.add(false);

            // assessCheckValue.add(false);
          }
      }
    }
  }

  String format1(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.yyyy}/${f.mm}/${f.dd}';
  }

  @override
  void initState() {
    getData();
    bottomSheetTextController = TextEditingController();
    bottomSheetGlobalKey = GlobalKey<FormState>();
    super.initState();
  }

  String? bottomSheetValidator(value) {
    if (value.isEmpty) {
      return 'خالی است!';
    }

    return null;
  }

  void _showBottomSheet(BuildContext context) {
    bottomSheetTextController.text = '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(10),
                    decoration: const InputDecoration(
                        labelText: 'نوع اطلاعات را انتخاب کنید'),
                    items: [
                      'متن',
                      'چک باکس',
                    ]
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        dropValue = value;
                      });
                      // Handle the selected value
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: bottomSheetGlobalKey,
                  child: TextFormField(
                    controller: bottomSheetTextController,
                    validator: bottomSheetValidator,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          gapPadding: 10,
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey[200]!)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      labelText: 'عنوان',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      alignLabelWithHint: true,
                    ),
                  ),
                ),

                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Text(
                //         'اضافه کردن به همه',
                //         style: TextStyle(fontSize: 16),
                //       ),
                //       SizedBox(
                //         width: 20,
                //         height:20,
                //         child: Checkbox(
                //           value: toAllCheck,
                //           onChanged: (newValue) {
                //             setState(() {
                //               toAllCheck = newValue!;
                //             });
                //             debugPrint('toAllCheck is: $toAllCheck');
                //           },
                //           tristate: false,
                //           splashRadius: 50,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle the button click
                    if (bottomSheetGlobalKey.currentState!.validate()) {
                      if (dropValue != null) {
                        assessValue = [];

                        assessmentList.add({
                          'title': bottomSheetTextController.text,
                          'type': dropValue,
                        });
                        Navigator.pop(context);
                        // if (toAllCheck) {
                        setState(() {
                          // assessmentList = [];
                        });
                        try {
                          MyPref().setAssessData(assessmentList);
                        } catch (e) {
                          debugPrint(
                              'getting assessment pref data error is: $e');
                        }
                        updateControllers();
                        // }
                        setState(() {
                          // assessmentList = [];
                        });
                      } else {
                        showSnackBarText('نوع فرم انتخاب نشد!', context);
                      }
                    }
                  },
                  child: const Text('اضافه کردن'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اضافه کردن ارزیابی',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            icon: const Icon(Icons.add_circle_outlined),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: assessmentList.length,
              itemBuilder: (context, index) {
                switch (assessmentList[index]['type']) {
                  case 'متن':
                    {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Form(
                          child: TextFormField(
                            controller: assessValue[index],
                            autofocus: true,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  gapPadding: 10,
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey[200]!)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                              labelText:
                                  assessmentList[index]['title'].toString(),
                              labelStyle: const TextStyle(fontSize: 16),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                      );
                    }
                  case 'چک باکس':
                    {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${assessmentList[index]['title']}:'),
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                value: assessValue[index],
                                onChanged: (newValue) {
                                  setState(() {
                                    assessValue[index] = newValue;
                                  });
                                },
                                splashRadius: 50,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  default:
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Form(
                        child: TextFormField(
                          autofocus: true,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                gapPadding: 10,
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey[200]!)),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10),
                            labelText:
                                assessmentList[index]['title'].toString(),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                    );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                List assessList = assessmentList;
                for (int i = 0; i < assessList.length; i++) {
                  switch (assessList[i]['type']) {
                    case 'متن':
                      {
                        assessList[i]['value'] = assessValue[i].text.toString();
                      }
                    case 'چک باکس':
                      {
                        assessList[i]['value'] = assessValue[i];
                      }
                  }
                }

                String dateNow = faNumber(format1(DateTime.now().toJalali()));
                userData.add({
                  'date': dateNow,
                  'assessment': assessList,
                  'createdAt': DateTime.now().toString()
                });
                assessmentData[widget.name] = userData;
                MyPref().setUserAssessment(assessmentData);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      name: widget.name,
                    ),
                  ),
                );
              },
              child: const Text('ذخیره'),
            ),
          ),
        ],
      ),
    );
  }
}
