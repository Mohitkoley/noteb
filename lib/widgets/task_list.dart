import 'package:flutter/material.dart';
import 'package:noteb/blocs/bloc_export.dart';
import 'package:noteb/widgets/task_tile.dart';

import '../model/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.tasksList,
  }) : super(key: key);

  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: tasksList.length,
          itemBuilder: (context, index) {
            Task task = tasksList[index];
            return TaskTile(task: task);
          }),
    );
  }
}
