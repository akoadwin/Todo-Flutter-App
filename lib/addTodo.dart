// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print

import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  AddTodo({
    super.key,
    required this.changeText,

    // required this.changeName,
    // required this.changeLastName
  });

  void Function({
    required String todoText,
  }) changeText;

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
  // TextEditingController nameText = TextEditingController();
  // TextEditingController lastNameText = TextEditingController();

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
        // TextField(
        //   autofocus: true,
        //   decoration: InputDecoration(
        //     hintText: 'Name',
        //   ),
        //   controller: nameText,
        // ),
        // TextField(
        //   autofocus: true,
        //   decoration: InputDecoration(
        //     hintText: 'Last Name',
        //   ),
        //   controller: lastNameText,
        // ),
        ElevatedButton(
            onPressed: () {
              print(todoText.text);

              widget.changeText(
                todoText: todoText.text,
              );
              // widget.changeName(
              //   nameText: nameText.text,
              // );
              //  widget.changeLastName(
              //   lastNameText: lastNameText.text,
              // );
              todoText.text = '';
              // nameText.text = '';
              // lastNameText.text = '';
            },
            child: Text("Add Button")),
      ],
    );
  }
}
