import 'package:faith_assessment/preferences.dart';
import 'package:flutter/material.dart';
import '../../model/const.dart';
import 'add_assess.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.name});
  final String name;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List assessments = [];
  getData() async {
    try {
      var assessData = await MyPref().getUserAssessment();
      setState(() {
        assessData[widget.name] != null
            ? assessments = assessData[widget.name]
            : null;
      });
      assessments.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
    } catch (e) {
      debugPrint('getting assessments data pref error is: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> assessment = [
    //   {
    //     'createdAt': '19/2/1401',
    //     'assessment': [
    //       {
    //         'title': 'نماز',
    //         'type': 'textInput',
    //         'value': '60',
    //       },
    //       {
    //         'title': 'تلاوت',
    //         'type': 'textInput',
    //         'value': '70',
    //       },
    //       {
    //         'title': 'اذکار',
    //         'type': 'textInput',
    //         'value': '90',
    //       },
    //       {
    //         'title': 'مطالعه',
    //         'type': 'textInput',
    //         'value': '60',
    //       },
    //       {
    //         'title': 'صوت',
    //         'type': 'bool',
    //         'value': true,
    //       },
    //     ]
    //   },
    //   {
    //     'createdAt': '19/2/1401',
    //     'assessment': [
    //       {
    //         'title': 'نماز',
    //         'type': 'textInput',
    //         'value': '60',
    //       },
    //       {
    //         'title': 'تلاوت',
    //         'type': 'textInput',
    //         'value': '70',
    //       },
    //       {
    //         'title': 'اذکار',
    //         'type': 'textInput',
    //         'value': '90',
    //       },
    //       {
    //         'title': 'مطالعه',
    //         'type': 'textInput',
    //         'value': '60',
    //       },
    //       {
    //         'title': 'صوت',
    //         'type': 'bool',
    //         'value': true,
    //       },
    //     ]
    //   },
    //   {
    //     'createdAt': '19/2/1401',
    //     'assessment': [
    //       {
    //         'title': 'نماز',
    //         'type': 'textInput',
    //         'value': '60',
    //       },
    //       {
    //         'title': 'تلاوت',
    //         'type': 'textInput',
    //         'value': '70',
    //       },
    //       {
    //         'title': 'اذکار',
    //         'type': 'textInput',
    //         'value': '90',
    //       },
    //       {
    //         'title': 'مطالعه',
    //         'type': 'textInput',
    //         'value': '60',
    //       },
    //       {
    //         'title': 'صوت',
    //         'type': 'bool',
    //         'value': true,
    //       },
    //     ]
    //   },
    //   {
    //     'createdAt': '19/2/1401',
    //     'assessment': [
    //       {
    //         'title': 'نماز',
    //         'type': 'textInput',
    //         'value': '60',
    //       },
    //       {
    //         'title': 'تلاوت',
    //         'type': 'textInput',
    //         'value': '70',
    //       },
    //       {
    //         'title': 'اذکار',
    //         'type': 'textInput',
    //         'value': '90',
    //       },
    //       {
    //         'title': 'مطالعه',
    //         'type': 'textInput',
    //         'value': '60',
    //       },
    //       {
    //         'title': 'صوت',
    //         'type': 'bool',
    //         'value': true,
    //       },
    //     ]
    //   },
    // ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name.toString(),
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddAssess(
                          name: widget.name.toString(), data: assessments)));
            },
            icon: const Icon(Icons.add_circle_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: assessments.length,
              itemBuilder: (context, index) {
                List assessmentList = assessments[index]['assessment'];
                assessmentList.sort((a, b) => a['type'].compareTo(b['type']));
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: Text(
                            faNumber(assessments[index]['date'].toString())),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children:
                                List.generate(assessmentList.length, (index) {
                              if (assessmentList[index]['type'] == 'چک باکس') {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${assessmentList[index]['title']}:'),
                                          SizedBox(
                                            width: 0,
                                            height: 0,
                                            child: Checkbox(
                                              value: assessmentList[index]
                                                  ['value'],
                                              onChanged: (newValue) {},
                                              tristate: true,
                                              splashRadius: 50,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (index != assessmentList.length - 1)
                                      const Divider(),
                                  ],
                                );
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${assessmentList[index]['title']}:'),
                                        Text(faNumber(assessmentList[index]
                                                ['value']
                                            .toString())),
                                      ],
                                    ),
                                    if (index != assessmentList.length - 1)
                                      const Divider(),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
