import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/module/todo.dart';
import 'package:to_do_list/widgets/todo_items.dart';
import 'constants/Colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todolist = ToDO.todolist();
  final todoController = TextEditingController();
  List<ToDO> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todolist;
    super.initState();
  }

  void _filter(String txt) {
    List<ToDO> result = [];
    if (txt.isEmpty) {
      result = todolist;
    } else {
      result = todolist
          .where((element) =>
          element.todText!.toLowerCase().contains(txt.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }

  void _handleToDoChange(ToDO todos) {
    setState(() {
      todos.isDone = !todos.isDone;
    });
  }

  void _deleteToDo(String id) {
    setState(() {
      todolist.removeWhere((e) => e.id == id);
    });
  }

  void _addToDO(String todo) {
    setState(() {
      if (todo == '') {
        const Text(
          "Text Field Can Not Be Empty",
          style: TextStyle(fontSize: 20, color: Colors.white),
        );
      } else {
        todolist.add(
            ToDO(id: DateTime.now().millisecond.toString(), todText: todo));
      }
    });
    todoController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BG,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 20, right: 20, left: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 12.0,
                                      spreadRadius: 0.0)
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: todoController,
                                decoration: const InputDecoration(
                                    hintText: "Add New ToDo",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(bottom: 20, right: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addToDO(todoController.text);
                                },
                                child:
                                    const Icon(Icons.add, color: red, size: 30),
                              ))
                        ],
                      ),
                    ),
                    searchBox(),
                    Expanded(
                        child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            "All ToDos",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        for (ToDO todo in _foundToDo.reversed)
                          ToDoItem(
                            todo: todo,
                            onToDoChange: _handleToDoChange,
                            onDeleteItem: _deleteToDo,
                          ),
                      ],
                    ))
                  ],
                )),
            // const SizedBox(height: 50),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           margin: const EdgeInsets.only(
            //               bottom: 20, right: 20, left: 20),
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 20, vertical: 5),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             boxShadow: const [
            //               BoxShadow(
            //                   color: Colors.grey,
            //                   offset: Offset(1.0, 1.0),
            //                   blurRadius: 12.0,
            //                   spreadRadius: 0.0)
            //             ],
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: TextField(
            //             controller: todoController,
            //             decoration: const InputDecoration(
            //                 hintText: "Add New ToDo",
            //                 hintStyle: TextStyle(color: Colors.grey),
            //                 border: InputBorder.none),
            //           ),
            //         ),
            //       ),
            //       Container(
            //           margin: const EdgeInsets.only(bottom: 20, right: 20),
            //           child: ElevatedButton(
            //             onPressed: () {
            //               _addToDO(todoController.text);
            //             },
            //             child: const Icon(Icons.add, color: red, size: 30),
            //           ))
            //     ],
            //   ),
            // )
          ],
        ));
  }
}

Widget searchBox() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(6)),
    child:  const TextField(
      // onChanged: (value)=>_filter(value),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        prefixIcon: Icon(Icons.search_rounded, color: black, size: 30),
        hintText: "Search",
        hintStyle: TextStyle(color: Grey, fontSize: 22),
      ),
    ),
  );
}

AppBar _buildAppBar() => AppBar(
    backgroundColor: BG,
    elevation: 0,
    title: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.menu,
          color: Colors.white,
          size: 30,
        ),
        Icon(Icons.person, color: Colors.white, size: 40)
      ],
    ));
