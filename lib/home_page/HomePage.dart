import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, bool> todos = {};
  final TextEditingController _todoTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTodoMap();
  }

  Future<void> loadTodoMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, bool> loadedTodos = {};
    List<String>? todoList = prefs.getStringList('todos');
    if (todoList != null) {
      for (String todo in todoList) {
        loadedTodos[todo] = false;
      }
    }
    setState(() {
      todos = loadedTodos;
    });
  }

  Future<void> saveTodoMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todos', todos.keys.toList());
  }

  void addTodo() {
    setState(() {
      String todo = _todoTextController.text.trim();
      if (todo.isNotEmpty) {
        todos[todo] = false;
        saveTodoMap();
        _todoTextController.clear();
      }
    });
  }

  void toggleTodoStatus(String todo) {
    setState(() {
      todos[todo] = !todos[todo]!;
      saveTodoMap();
    });
  }

  void removeTodo(String todo) {
    setState(() {
      todos.remove(todo);
      saveTodoMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      {
        'name': 'احمد',
        'assessment': 'نماز: 50: تلاوت: 60 اذکار:30 مطالعه: 100 ',
        'createdAt': '19/2/1401',
      },
      {
        'name': 'محمود',
        'assessment': 'نماز: 40: تلاوت: 20 اذکار:80 مطالعه: 75 ',
        'createdAt': '19/2/1401',
      },
      {
        'name': 'کریم',
        'assessment': 'نماز: 10: تلاوت: 40 اذکار:20 مطالعه: 15 ',
        'createdAt': '19/2/1401',
      },
      {
        'name': 'مقصود',
        'assessment': 'نماز: 60: تلاوت: 80 اذکار:20 مطالعه: 90 ',
        'createdAt': '19/2/1401',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'محاسب',
          style: TextStyle(fontFamily: 'iransans', fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                // String todo = todos.keys.toList()[index];
                // bool isCompleted = todos[todo]!;
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                  data: data[index],
                                )));
                  },
                  title: Text(
                    data[index]['name'].toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                        // decoration:
                        // isCompleted ? TextDecoration.lineThrough : null,
                        ),
                  ),
                  subtitle: Text(
                    data[index]['assessment'].toString(),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal
                        // decoration:
                        // isCompleted ? TextDecoration.lineThrough : null,
                        ),
                  ),
                  trailing: Text(
                    data[index]['createdAt'].toString(),
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  // onLongPress: () => removeTodo(todo),
                );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: _todoTextController,
          //           decoration: InputDecoration(
          //             hintText: 'Enter a todo...',
          //           ),
          //         ),
          //       ),
          //       ElevatedButton(
          //         onPressed: addTodo,
          //         child: Text('Add'),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

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
                  MaterialPageRoute(builder: (context) => AddAssess()));
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

class AddAssess extends StatelessWidget {
  AddAssess({super.key});
  final list = [
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
  ];

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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        child: TextFormField(
                          autofocus: true,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[400],
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
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
