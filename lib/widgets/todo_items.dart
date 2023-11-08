import 'package:flutter/material.dart';
import 'package:to_do_list/constants/Colors.dart';
import 'package:to_do_list/module/todo.dart';

class ToDoItem extends StatefulWidget {
  final ToDO todo;
  final onToDoChange;
  final onDeleteItem;

  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChange,
      required this.onDeleteItem})
      : super(key: key);

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          widget.onToDoChange(widget.todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.white,
        leading: Icon(
          widget.todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: blue,
        ),
        title: Text(widget.todo.todText!,
            style: TextStyle(
              fontSize: 18,
              color: black,
              decoration:
                  widget.todo.isDone ? TextDecoration.lineThrough : null,
            )),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 20,
            icon: const Icon(Icons.delete),
            onPressed: () {
              // print("delete");
              widget.onDeleteItem(widget.todo.id);
            },
          ),
        ),
      ),
    );
  }
}
