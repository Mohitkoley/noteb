import 'package:flutter/material.dart';
import 'package:noteb/widgets/task_list.dart';

import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  static const id = "recycle_bin";
  const RecycleBin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            ))
      ]),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [Chip(label: Text("Tasks")), TaskList(tasksList: [])],
      ),
    );
  }
}
