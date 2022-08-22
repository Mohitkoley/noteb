import "package:flutter/material.dart ";
import 'package:intl/intl.dart';
import 'package:noteb/screens/edit_task_screen.dart';
import 'package:noteb/widgets/popup_menu.dart';
import "../blocs/bloc_export.dart";
import '../model/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleted(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: EditTaskScreen(
                    oldTask: task,
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              task.isFavorite == false
                  ? Icon(Icons.star_outline)
                  : Icon(Icons.star),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
                    Text(DateFormat("dd/MM/yyyy hh:mm")
                        .format(DateTime.parse(task.date))),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: task.isDone,
              onChanged: task.isDeleted == false
                  ? (value) {
                      context.read<TasksBloc>().add(UpdateTask(task: task));
                    }
                  : null,
            ),
            PopupMenu(
              editTaskCallback: () {
                _editTask(context);
                Navigator.pop(context);
              },
              task: task,
              likeOrDislikeCallback: () => context
                  .read<TasksBloc>()
                  .add(MarkFavoriteorUnFavoriteTask(task: task)),
              cancelOrDeleteCallBack: () => _removeOrDeleted(context, task),
              restoreTaskCallback: () {
                context.read<TasksBloc>().add(RestoreTask(task: task));
              },
            )
          ],
        ),
      ],
    );
  }
}
