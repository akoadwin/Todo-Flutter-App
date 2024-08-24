// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TodoListBuilder extends StatefulWidget {
  TodoListBuilder(
      {super.key, required this.todoList, required this.updateLocalData});

  List<String> todoList;

  void Function() updateLocalData;

  @override
  State<TodoListBuilder> createState() => _TodoListBuilderState();
}

class _TodoListBuilderState extends State<TodoListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: (widget.todoList.isEmpty)
          ? const Center(
              child: Text(
                "Todo List is Empty ",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: widget.todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      widget.todoList.removeAt(index);
                    });
                    widget.updateLocalData();
                  },
                  background: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade300,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Mark as done",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  key: UniqueKey(),
                  child: ListTile(
                    // tileColor: Colors.blueGrey.shade100,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.todoList.removeAt(index);
                                    });
                                    widget.updateLocalData();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Mark as done"),
                                ),
                              ),
                            );
                          });
                    },
                    title: Text(widget.todoList[index]),
                  ),
                );
              }),
    );
  }
}
