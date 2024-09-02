import 'package:flutter/material.dart';
import 'package:todo_app/Modal/to_do.dart';
import 'package:todo_app/constraints/colors.dart';
import 'package:todo_app/widget/toDoitems.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todolist = Todo.toDoList();
  List<Todo> _Foundtodo = [];
  final _textinput = TextEditingController();

  @override
  void initState() {
    _Foundtodo = todolist;
    super.initState();
  }

  void onChangeStatus(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _runFilter(String enteredKeyword){
    List<Todo> result = [];
    if(enteredKeyword.isEmpty) {
      result = todolist;
    }
    else{
      result = todolist.where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _Foundtodo = result;
    });
  }

  void deleteItems(String id) {
    setState(() {
      todolist.removeWhere((moiz) => moiz.id == id);
    });
  }

  void additem(String todo) {
    setState(() {
      todolist.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _textinput.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: Customappbar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                searchBar(onChangeSearch: _runFilter,),
                Expanded(
                 child: ListView(
                    padding: EdgeInsets.only(top: 50, bottom: 20),
                    shrinkWrap: true,
                    children: [
                      Text('To-do Items',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: tdBlack,
                          )),
                      if (_Foundtodo.isEmpty)
                        Center(
                          child: Text(
                            "No Result Found",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        for (var todoo in _Foundtodo.reversed)
                          toDoitems(
                            todo: todoo,
                            onChangeItems: onChangeStatus,
                            onDeleteItems: deleteItems,
                          )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: tdGrey,
                            blurRadius: 6.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 0.0))
                      ]),
                  child: TextField(
                    controller: _textinput,
                    maxLength: 45,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add a new item',
                        hintStyle: TextStyle(color: tdGrey)),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 15),
                  child: ElevatedButton(
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      onPressed: () {
                        if(_textinput.text.isEmpty)
                          Fluttertoast.showToast(msg: "Please Write something");
                        else
                        additem(_textinput.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: tdBlue,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(60, 60))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class searchBar extends StatelessWidget {

  final Function(String) onChangeSearch;

  const searchBar({super.key, required this.onChangeSearch});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
      onChanged: onChangeSearch,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minHeight: 20),
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }
}

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: tdBGColor,
      backgroundColor: tdBGColor,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(msg: "Will implement in next build");
            },
            child: Icon(
            Icons.menu,
            size: 30,
            color: tdBlack,
          ),
          ),
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(msg: "Will implement in next build");
            },
            child: Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/avatar.jpeg'),
              ),
            ),
          )
        ],
      ),
    );
  }



  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 56);
}
