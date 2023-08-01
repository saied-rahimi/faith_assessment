import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/my_dialog.dart';
import 'details_page.dart';

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
