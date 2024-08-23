// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print

import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  AddTodo({
    super.key,
    required this.addTodo,
    // required this.changeName,
    // required this.changeLastName
  });

  void Function({
    required String todoText,
  }) addTodo;

  // void Function({
  //   required String nameText,
  // }) changeName;
  // void Function({
  //   required String lastNameText,
  // }) changeLastName;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Add A Todo "),
        TextField(
          autofocus: true,
          decoration: InputDecoration(labelText: 'Add some todo'),
          controller: todoText,
        ),
        ElevatedButton(
            onPressed: () {
              if (todoText.text.isNotEmpty) {
                widget.addTodo(todoText: todoText.text);
              }
              todoText.text = '';
            },
            child: Text("Add Button")),
      ],
    );
  }
}
