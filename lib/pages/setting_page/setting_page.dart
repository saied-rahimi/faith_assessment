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
  late TextEditingController bottomSheetTextController;
  late GlobalKey<FormState> bottomSheetGlobalKey;
  @override
  void initState() {
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
                Form(
                  key: bottomSheetGlobalKey,
                  child: TextFormField(
                    controller: bottomSheetTextController,
                    autofocus: true,
                    validator: bottomSheetValidator,
                    style: const TextStyle(
                      fontSize: 20,
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
                const SizedBox(height: 16.0),
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
                      setState(() {});
                      // Handle the selected value
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle the button click
                    if (bottomSheetGlobalKey.currentState!.validate()) {}
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List profilePageData = [
    {
      'title': 'حساب',
      'leading': Icons.account_circle_outlined,
      'onTap': () {
        debugPrint('11111');
      }
    },
    {
      'title': 'اعضاء',
      'leading': Icons.add_chart_sharp,
      'onTap': () {
        debugPrint('22222');
      }
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.asset(
                  'assets/icons/Setting.png',
                  height: 100,
                  color: Colors.grey[400],
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'تنظیمات',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: profilePageData
                  .map(
                    (value) => ListTile(
                      minVerticalPadding: 25,
                      title: Text(value['title'].toString()),
                      leading: CircleAvatar(
                        child: Icon(value['leading']),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      ),
                      onTap: value['onTap'],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
