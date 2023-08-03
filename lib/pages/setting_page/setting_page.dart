// ignore_for_file: use_build_context_synchronously

import 'package:faith_assessment/model/my_dialog.dart';
import 'package:faith_assessment/pages/setting_page/members_page.dart';
import 'package:faith_assessment/pages/navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../prefrences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<Map<String, dynamic>> myDataList = [];
  Map<String, dynamic> dataMap = {};
  String? dropValue;
  List profilePageData = [
    {
      'title': 'حساب',
      'leading': Icons.account_circle_outlined,
    },
    {
      'title': 'اعضاء',
      'leading': Icons.add_chart_sharp,
    },
  ];
  Map? managerData;

  late TextEditingController bottomSheetNameController;
  late GlobalKey<FormState> bottomSheetNameKey;
  late TextEditingController bottomSheetLocationController;
  late GlobalKey<FormState> bottomSheetLocationKey;

  String? bottomSheetNameValidator(value) {
    if (value.isEmpty) {
      return 'خالی است!';
    }
    return null;
  }

  String? bottomSheetLocationValidator(value) {
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
              // mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: bottomSheetNameKey,
                  child: TextFormField(
                    controller: bottomSheetNameController,
                    autofocus: true,
                    validator: bottomSheetNameValidator,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'نام و تخلص مدیر برنامه',
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 12),
                      border: OutlineInputBorder(
                          gapPadding: 10,
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey[200]!)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      labelText: 'نام و تخلص',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: bottomSheetLocationKey,
                  child: TextFormField(
                    controller: bottomSheetLocationController,
                    autofocus: true,
                    validator: bottomSheetLocationValidator,
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
                      labelText: 'موقعیت(شعبه)',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(10),
                    decoration: const InputDecoration(labelText: 'صنف چندم؟'),
                    items: [
                      '1',
                      '2',
                      '3',
                      '4',
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
                ElevatedButton(
                  onPressed: () async {
                    // Handle the button click
                    if (bottomSheetNameKey.currentState!.validate()) {
                      if (dropValue != null) {
                        Map<String, dynamic> managerData = {
                          'name': bottomSheetNameController.text.toString(),
                          'location':
                              bottomSheetLocationController.text.toString(),
                          'level': dropValue,
                        };
                        MyPref().setManagerData(managerData);
                        try {
                          var data = await MyPref().getManagerData();
                          debugPrint('pref data is: $data');
                          setState(() {
                            managerData = data;
                          });
                        } catch (e) {
                          debugPrint('getting ManagerData error is: $e');
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyNavigationBar(
                                      page: 1,
                                    )),
                            (route) => false);
                      } else {
                        showSnackBarText('فرم را تکمیل کنید!', context);
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  getData() async {
    try {
      var data = await MyPref().getManagerData();
      setState(() {
        managerData = data;
      });
    } catch (e) {
      debugPrint('getting ManagerData error is: $e');
    }
  }

  @override
  void initState() {
    getData();
    bottomSheetNameController = TextEditingController();
    bottomSheetLocationController = TextEditingController();
    bottomSheetNameKey = GlobalKey<FormState>();
    bottomSheetLocationKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/icons/Setting.png',
                height: 100,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'تنظیمات',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            managerData != null
                ? Text(
                    "مدیر: ${managerData!['name']}",
                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                  )
                : Container(),
            managerData != null
                ? const SizedBox(
                    height: 20,
                  )
                : Container(),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profilePageData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      minVerticalPadding: 25,
                      title: Text(
                        profilePageData[index]['title'].toString(),
                      ),
                      leading: CircleAvatar(
                        child: Icon(
                          profilePageData[index]['leading'],
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      ),
                      onTap: () {
                        if (index == 0) {
                          _showBottomSheet(context);
                        }
                        if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MemberPage()));
                        }
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
