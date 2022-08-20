import 'package:flutter/material.dart';
import 'package:noteb/screens/add_task_screen.dart';
import 'package:noteb/screens/completed_task_screen.dart';
import 'package:noteb/screens/favorite_task_screen.dart';
import 'package:noteb/screens/my_drawer.dart';
import 'package:noteb/screens/pending_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  static const id = "tabs_screen";

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _PageDetailes = [
    {"pageName": PendingTaskScreen(), "title": "Pending Tasks"},
    {"pageName": CompletedTaskScreen(), "title": "completed Tasks"},
    {"pageName": FavoriteTaskScreen(), "title": "Favorite Tasks"},
  ];

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTaskScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_PageDetailes[_selectedIndex]["title"]),
          actions: [
            IconButton(
              onPressed: () => _addTask(context),
              icon: Icon(Icons.add),
            )
          ],
        ),
        drawer: MyDrawer(),
        body: _PageDetailes[_selectedIndex]["pageName"],
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () => _addTask(context),
                tooltip: "Add Task",
                child: const Icon(Icons.add))
            : null,
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.incomplete_circle_sharp),
                  label: "Pending Tasks"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done), label: "Completed Tasks"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorite Tasks"),
            ]));
  }
}
