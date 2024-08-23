import 'package:flutter/material.dart';

// ignore: must_be_immutable
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

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Add A Todo "),
        TextField(
          onSubmitted: (value) {
            if (todoText.text.isNotEmpty) {
              widget.addTodo(todoText: todoText.text);
            }
            todoText.text = '';
          },
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Add some todo'),
          controller: todoText,
        ),
        ElevatedButton(
            onPressed: () {
              if (todoText.text.isNotEmpty) {
                widget.addTodo(todoText: todoText.text);
              }
              todoText.text = '';
            },
            child: const Text("Add Button")),
      ],
    );
  }
}
