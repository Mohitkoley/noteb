import 'package:flutter/material.dart';
import 'package:noteb/widgets/task_list.dart';

import '../blocs/bloc_export.dart';
import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  static const id = "recycle_bin";
  const RecycleBin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar:
              AppBar(title: Text("Recycle Bin"), centerTitle: true, actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.delete_forever),
                            label: Text("Delete All Tasks")),
                        onTap: () =>
                            context.read<TasksBloc>().add(DeleteAllTask()),
                      )
                    ])
          ]),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(label: Text("Tasks ${state.removedTask.length}")),
              TaskList(tasksList: state.removedTask)
            ],
          ),
        );
      },
    );
  }
}
