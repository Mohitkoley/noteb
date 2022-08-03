import "package:flutter/material.dart ";
import "../blocs/bloc_export.dart";
import '../model/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title,
          style: TextStyle(
              decoration: task.isDone!
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          context.read<TasksBloc>().add(UpdateTask(task: task));
        },
      ),
      onLongPress: () => context.read<TasksBloc>().add(DeleteTask(task: task)),
    );
  }
}
