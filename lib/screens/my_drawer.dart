import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteb/screens/recycle_bin.dart';

import '../blocs/bloc_export.dart';
import 'task_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child:
                  Text("Drawer", style: Theme.of(context).textTheme.headline5),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(TaskScreen.id),
                  child: ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text("Home"),
                      trailing: Text("${state.allTasks.length}")),
                );
              },
            ),
            const Divider(),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(RecycleBin.id),
              child: const ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Bin"),
                trailing: const Text("0"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
