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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasksList
              .map((task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: ((context, isExpanded) => TaskTile(
                        task: task,
                      )),
                  body: ListTile(
                    title: SelectableText.rich(TextSpan(children: [
                      TextSpan(
                          text: "Text\n",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: task.title),
                      TextSpan(
                          text: "\n\nDescription\n",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: task.description)
                    ])),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
