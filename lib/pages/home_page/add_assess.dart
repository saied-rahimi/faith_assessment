import 'package:flutter/material.dart';

import '../../model/my_dialog.dart';

class AddAssess extends StatefulWidget {
  const AddAssess({super.key});

  @override
  State<AddAssess> createState() => _AddAssessState();
}

class _AddAssessState extends State<AddAssess> {
  final list = [
    {
      'title': 'نماز',
      'type': 'textInput',
    },
    {
      'title': 'تلاوت',
      'type': 'textInput',
    },
    {
      'title': 'اذکار',
      'type': 'textInput',
    },
    {
      'title': 'مطالعه',
      'type': 'textInput',
    },
    {
      'title': 'صوت',
      'type': 'bool',
    },
  ];
  String? dropValue;
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
                      setState(() {
                        dropValue = value;
                      });
                      // Handle the selected value
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle the button click
                    if (bottomSheetGlobalKey.currentState!.validate()) {
                      if (dropValue != null) {
                        String value = 'textInput';
                        switch (dropValue.toString()) {
                          case 'متن':
                            value = 'textInput';
                            break;
                          case 'چک باکس':
                            value = 'bool';
                        }
                        list.add({
                          'title': bottomSheetTextController.text,
                          'type': value,
                          'value': '60',
                        });
                        setState(() {});
                        Navigator.pop(context);
                      } else {
                        showSnackBarText('نوع فرم انتخاب نشد!', context);
                      }
                    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافه کردن ارزیابی'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                switch (list[index]['type']) {
                  case 'textInput':
                    {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Form(
                          child: TextFormField(
                            autofocus: true,
                            style: const TextStyle(
                              fontSize: 20,
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
                              labelText: list[index]['title'].toString(),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                      );
                    }
                  case 'bool':
                    {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${list[index]['title']}:'),
                            SizedBox(
                              width: 20,
                              height: 2,
                              child: Checkbox(
                                value: false,
                                onChanged: (newValue) {},
                                tristate: true,
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
                            fontSize: 20,
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
                            labelText: list[index]['title'].toString(),
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
                _showBottomSheet(context);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
