import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteb/blocs/bloc/tasks_bloc.dart';
import 'package:noteb/screens/add_task_screen.dart';
import 'package:noteb/screens/my_drawer.dart';
import 'package:noteb/widgets/task_list.dart';

import '../model/task.dart';

class TaskScreen extends StatelessWidget {
  static const id = "task_screen";
  TaskScreen({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();

  void _addTask(BuildContext context) {
    showModalBottomSheet(
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
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> tasks = state.allTasks;
      return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () => _addTask(context),
              icon: const Icon(
                Icons.add,
              ))
        ]),
        drawer: MyDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chip(label: Text("${state.allTasks.length} Tasks")),
            TaskList(tasksList: tasks)
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: "Add Task",
            child: const Icon(Icons.add)),
      );
    });
  }
}
