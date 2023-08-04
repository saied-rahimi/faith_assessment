import 'package:faith_assessment/preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, bool> todos = {};
  var memberData = [];
  final TextEditingController _todoTextController = TextEditingController();
  getData() async {
    var data = await MyPref().getMemberData();
    setState(() {
      memberData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
              itemCount: memberData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          name: memberData[index]['name'],
                        ),
                      ),
                    );
                  },
                  title: Text(
                    memberData[index]['name'].toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold
                        // decoration:
                        // isCompleted ? TextDecoration.lineThrough : null,
                        ),
                  ),
                  subtitle: Text(
                    memberData[index]['assessment'].toString(),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal
                        // decoration:
                        // isCompleted ? TextDecoration.lineThrough : null,
                        ),
                  ),
                  trailing: Text(
                    memberData[index]['date'].toString(),
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
