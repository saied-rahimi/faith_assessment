import 'package:faith_assessment/prefrences.dart';
import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  late TextEditingController bottomSheetNameController;
  late GlobalKey<FormState> bottomSheetNameKey;
  late TextEditingController bottomSheetLocationController;
  late GlobalKey<FormState> bottomSheetLocationKey;
  late TextEditingController bottomSheetJobController;
  late GlobalKey<FormState> bottomSheetJobKey;
  late TextEditingController bottomSheetAgeController;
  late GlobalKey<FormState> bottomSheetAgeKey;
  List memberList = [];
  String manager = '0';
  String level = '0';

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
                  key: bottomSheetJobKey,
                  child: TextFormField(
                    controller: bottomSheetJobController,
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
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      labelText: 'شغل',
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
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      labelText: 'محل سکونت',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: bottomSheetAgeKey,
                  child: TextFormField(
                    controller: bottomSheetAgeController,
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
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      labelText: 'سن',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    // Handle the button click
                    if (bottomSheetNameKey.currentState!.validate()) {
                      Map data = {
                        'name': bottomSheetNameController.text.toString(),
                        'job': bottomSheetJobController.text.toString(),
                        'age': bottomSheetAgeController.text.toString(),
                        'location':
                            bottomSheetLocationController.text.toString()
                      };

                      setState(() {
                        memberList.add(data);
                      });

                      Navigator.pop(context);
                    }
                  },
                  child: const Text('اضافه کردن'),
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
      var data = await MyPref().getMemberData();
      debugPrint('getMemberData is: $data');
      setState(() {
        memberList = data;
      });
    } catch (e) {
      debugPrint('getting member data pref error is: $e');
    }
    try {
      var data = await MyPref().getManagerData();
      manager = data['name'];
      level = data['level'];
    } catch (e) {
      debugPrint('getting manager data pref error is: $e');
    }
  }

  @override
  void initState() {
    getData();
    bottomSheetNameController = TextEditingController();
    bottomSheetLocationController = TextEditingController();
    bottomSheetNameKey = GlobalKey<FormState>();
    bottomSheetLocationKey = GlobalKey<FormState>();
    bottomSheetAgeController = TextEditingController();
    bottomSheetJobController = TextEditingController();
    bottomSheetAgeKey = GlobalKey<FormState>();
    bottomSheetJobKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('data is: $memberList');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اعضاء',
          style: TextStyle(fontSize: 20),
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          '${memberList[index]['name']}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.8),
                        ),
                        subtitle: Text(
                          'شغل: ${memberList[index]['job']}    '
                          'سن: ${memberList[index]['age']}   '
                          'مدیر: $manager   \n'
                          'صنف: $level   '
                          'محل سکونت: ${memberList[index]['location']}',
                          style: TextStyle(
                              color: Colors.grey[400], fontSize: 14, height: 2),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  MyPref().setMemberData(memberList);
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
