import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/add_todo_form.dart';
import 'package:todo_app/widgets/todo_list.dart';
import 'package:url_launcher/url_launcher.dart';

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
              title: const Text("Already Exist"),
              content: Text("$todoText is already Exist"),
              actions: [
                InkWell(
                  child: const Text("Close"),
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

  void showBottomModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              SingleChildScrollView(
                  child: Container(
                margin: const EdgeInsets.all(15),
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
  }

  @override
  void initState() {
    loadLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: (Colors.blueGrey.shade900),
            onPressed: showBottomModal,
            child: const Icon(
              Icons.add_circle_outline_sharp,
              size: 28,
            )),
        resizeToAvoidBottomInset: true,
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    height: 140,
                    child: UserAccountsDrawerHeader(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade900,
                            borderRadius: BorderRadius.circular(4)),
                        accountName: const Center(
                          child: Text(
                            "TODO APP",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        accountEmail: const Text("")),
                  )),
              const SizedBox(
                height: 18,
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse('https://github.com/akoadwin'));
                },
                leading: const Icon(
                  Icons.person_4_sharp,
                ),
                title: const Text(
                  "About Me",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrl(Uri.parse('mailto:floresgodwin@gg.com'));
                },
                leading: const Icon(
                  Icons.email_sharp,
                ),
                title: const Text(
                  "Contact me",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("TODO APP"),
          centerTitle: true,
        ),
        body: TodoListBuilder(
            todoList: todoList, updateLocalData: updateLocalData));
  }
}
