import 'package:flutter/material.dart';
import 'package:todo_app/Home.dart';
import 'package:todo_app/constraints/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/Modal/to_do.dart';

class toDoitems extends StatelessWidget {
  final Todo todo ;
  final onChangeItems;
  final onDeleteItems;
  const toDoitems({
    super.key,
    required this.todo,
    required this.onChangeItems,
    required this.onDeleteItems
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: (){
          onChangeItems(todo);
        },
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone? Icons.check_box : Icons.check_box_outline_blank, color: tdBlue),
        title: Text(
            todo.todoText!,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
            decoration: todo.isDone? TextDecoration.lineThrough: null,
        )),
        trailing: Container(
          //padding: EdgeInsets.symmetric(vertical: ),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(10)
          ),
          child: GestureDetector(
            onTap: (){
              onDeleteItems(todo.id);
            },
            child:Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )

        ),

      ),
    );
  }
}
