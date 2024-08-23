// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/addTodo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> todoList = [];

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Already Exist"),
              content: Text("$todoText is already Exist"),
              actions: [
                InkWell(
                  child: Text("Close"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return;
    }
    setState(() {
      todoList.insert(0, todoText);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('todoList', todoList);
  }

  void loadLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = (prefs.getStringList('todoList') ?? []).toList();
    });
  }

  @override
  void initState() {
    loadLocalData();
    super.initState();
  }

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
                            padding: MediaQuery.of(context).viewInsets,
                            child: AddTodo(
                              addTodo: addTodo,
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
          title: Text("TODO APP"),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onLongPress: () {
                  print('Long Pressed');
                },
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  todoList.removeAt(index);
                                });
                                updateLocalData();
                                Navigator.pop(context);
                              },
                              child: Text("Mark as done"),
                            ),
                          ),
                        );
                      });
                },
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
