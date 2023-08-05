import 'package:faith_assessment/preferences.dart';
import 'package:flutter/material.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, bool> todos = {};
  var membersData = {};
  List keysList = [];
  getData() async {
    var data = await MyPref().getMemberData();
    debugPrint('data is: $data');
    setState(() {
      membersData = data;
    });
    keysList = membersData.keys.toList();
  }

  @override
  void initState() {
    super.initState();
    getData();
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
              itemCount: keysList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                name: keysList[index],
                              ),
                            ),
                          );
                        },
                        title: Text(
                          keysList[index].toString(),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        )
                        // onLongPress: () => removeTodo(todo),
                        ),
                    const Divider(),
                  ],
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
