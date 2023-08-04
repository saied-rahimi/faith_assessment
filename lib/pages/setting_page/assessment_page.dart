import 'package:faith_assessment/model/my_dialog.dart';
import 'package:faith_assessment/preferences.dart';
import 'package:flutter/material.dart';

class AssessmentPage extends StatefulWidget {
  const AssessmentPage({super.key});

  @override
  State<AssessmentPage> createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  List assessList = [];
  String? dropValue;
  List defaultAssess = [
    {'title': 'جماعت', 'type': 'متن'},
    {'title': 'تلاوت', 'type': 'متن'},
    {'title': 'اذکار', 'type': 'متن'},
    {'title': 'مطالعه', 'type': 'متن'},
  ];
  late TextEditingController bottomSheetTextController;
  late GlobalKey<FormState> bottomSheetGlobalKey;
  getData() async {
    var data = await MyPref().getAssessData();
    setState(() {
      assessList = data;
    });
    assessList.sort((a, b) => a['type'].compareTo(b['type']));

    // if(assessList.isEmpty){
    //   setState(() {
    //     assessList = defaultAssess;
    //   });
    // }
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
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle the button click
                    if (bottomSheetGlobalKey.currentState!.validate()) {
                      if (dropValue != null) {
                        assessList.add({
                          'title': bottomSheetTextController.text,
                          'type': dropValue,
                        });
                        setState(() {});
                        Navigator.pop(context);
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
          'اضافه کردن ارزیابی کلی',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                assessList = defaultAssess;
              });
            },
            icon: const Icon(Icons.restart_alt_rounded),
          ),
          IconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            icon: const Icon(Icons.add_circle_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: assessList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${assessList[index]['title']}'),
                    trailing: Text('${assessList[index]['type']}'),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  assessList.sort((a, b) => a['type'].compareTo(b['type']));
                  MyPref().setAssessData(assessList);
                  Navigator.pop(context);
                },
                child: const Text('ذخیره'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
