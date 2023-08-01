import 'package:flutter/material.dart';

import 'add_assess.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> assessment = [
      {
        'createdAt': '19/2/1401',
        'assessment': [
          {
            'title': 'نماز',
            'type': 'textInput',
            'value': '60',
          },
          {
            'title': 'تلاوت',
            'type': 'textInput',
            'value': '70',
          },
          {
            'title': 'اذکار',
            'type': 'textInput',
            'value': '90',
          },
          {
            'title': 'مطالعه',
            'type': 'textInput',
            'value': '60',
          },
          {
            'title': 'صوت',
            'type': 'bool',
            'value': true,
          },
        ]
      },
      {
        'createdAt': '19/2/1401',
        'assessment': [
          {
            'title': 'نماز',
            'type': 'textInput',
            'value': '60',
          },
          {
            'title': 'تلاوت',
            'type': 'textInput',
            'value': '70',
          },
          {
            'title': 'اذکار',
            'type': 'textInput',
            'value': '90',
          },
          {
            'title': 'مطالعه',
            'type': 'textInput',
            'value': '60',
          },
          {
            'title': 'صوت',
            'type': 'bool',
            'value': true,
          },
        ]
      },
      {
        'createdAt': '19/2/1401',
        'assessment': [
          {
            'title': 'نماز',
            'type': 'textInput',
            'value': '60',
          },
          {
            'title': 'تلاوت',
            'type': 'textInput',
            'value': '70',
          },
          {
            'title': 'اذکار',
            'type': 'textInput',
            'value': '90',
          },
          {
            'title': 'مطالعه',
            'type': 'textInput',
            'value': '60',
          },
          {
            'title': 'صوت',
            'type': 'bool',
            'value': true,
          },
        ]
      },
      {
        'createdAt': '19/2/1401',
        'assessment': [
          {
            'title': 'نماز',
            'type': 'textInput',
            'value': '60',
          },
          {
            'title': 'تلاوت',
            'type': 'textInput',
            'value': '70',
          },
          {
            'title': 'اذکار',
            'type': 'textInput',
            'value': '90',
          },
          {
            'title': 'مطالعه',
            'type': 'textInput',
            'value': '60',
          },
          {
            'title': 'صوت',
            'type': 'bool',
            'value': true,
          },
        ]
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddAssess()));
            },
            icon: const Icon(Icons.add_circle_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: assessment.length,
              itemBuilder: (context, index) {
                List? assessmentList = assessment[index]['assessment'];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: Text(assessment[index]['createdAt'].toString()),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children:
                                List.generate(assessmentList!.length, (index) {
                              if (assessmentList[index]['type'] == 'bool') {
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
                                        Text(assessmentList[index]['value']
                                            .toString()),
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
