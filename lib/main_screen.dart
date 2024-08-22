// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:todo_app/addTodo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? text = ' ';
  String? name = ' ';
  String? lastName = ' ';

  List<String> todoList = [
    "Code",
    "Sleep",
    "Coffee",
  ];

  void changeText({
    required String? todoText,
  }) {
    setState(() {
      text = todoText ?? "NO VALUE";
    });
  }

  // void changeName({required String? nameText}) {
  //   setState(() {
  //     name = nameText ?? "NO VALUE";
  //   });
  // }

  // void changeLastName({required String? lastNameText}) {
  //   setState(() {
  //     lastName = lastNameText ?? "NO VALUE";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: Drawer(
          child: Text("Inside Of this Drawer"),
        ),
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          SingleChildScrollView(
                              child: Container(
                            margin: EdgeInsets.all(15),
                            // height: 200,
                            padding: MediaQuery.of(context).viewInsets,
                            child: AddTodo(
                              changeText: changeText,
                              // changeName: changeName,
                              // changeLastName: changeLastName,
                            ),
                          ))
                        ],
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FeatherIcons.plus,
                  size: 25,
                ),
              ),
            ),
          ],
          title: Text("Todo App"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(todoList[index]),
              );
            })
        // Container(
        //     padding: EdgeInsets.all(10),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(text ?? "No Initial Todo Value"),
        //         Text(name ?? "No Name"),
        //         Text(lastName ?? "No Last Name"),
        //       ],
        //     ))

        );
  }
}
