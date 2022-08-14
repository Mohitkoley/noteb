import 'package:flutter/material.dart';
import 'package:noteb/screens/recycle_bin.dart';
import 'package:noteb/screens/tabs_screen.dart';
import '../blocs/bloc_export.dart';
import 'pending_screen.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

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
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(TabsScreen.id),
                  child: ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text("Home"),
                      trailing: Text(
                          "${state.pendingTasks.length} | ${state.completedTasks.length}")),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text("Bin"),
                    trailing: Text("${state.removedTask.length}"),
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                  value: state.switchValue,
                  onChanged: (value) {
                    value
                        ? context.read<SwitchBloc>().add(SwitchOnEvent())
                        : context.read<SwitchBloc>().add(SwitchOffEvent());
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
