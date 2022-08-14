import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteb/blocs/task_bloc/tasks_bloc.dart';
import 'package:noteb/widgets/task_list.dart';

import '../model/task.dart';

class PendingTaskScreen extends StatelessWidget {
  static const id = "task_screen";
  PendingTaskScreen({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      List<Task> tasksList = state.pendingTasks;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Chip(
              label: Text(
                  "${tasksList.length} Pending | ${state.completedTasks.length} Completed")),
          TaskList(tasksList: tasksList)
        ],
      );
      // ignore: prefer_const_literals_to_create_immutables
    });
  }
}
