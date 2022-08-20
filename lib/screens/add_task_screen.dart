import 'package:flutter/material.dart';
import 'package:noteb/blocs/bloc_export.dart';
import 'package:noteb/model/task.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool _validate = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Text("Add Task", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 24),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a title";
              }
              return null;
            },
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Task title",
                errorText: _validate ? "Title is required" : null,
                errorStyle: const TextStyle(color: Colors.red),
                label: const Text("Title"),
                border: const OutlineInputBorder()),
            controller: titleController,
          ),
          const SizedBox(height: 24),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a description";
              }
              return null;
            },
            autofocus: true,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
                hintText: "Task Description",
                errorText: _validate ? "description is required" : null,
                errorStyle: const TextStyle(color: Colors.red),
                label: const Text("Title"),
                border: const OutlineInputBorder()),
            controller: descriptionController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                  onPressed: () => validator(context),
                  child: const Text("Add")),
            ],
          )
        ],
      ),
    );
  }

  validator(
    BuildContext context,
  ) {
    if (formKey.currentState!.validate()) {
      setState(() {
        titleController.text.isEmpty ? _validate = true : _validate = false;
        Task task = Task(
            title: titleController.text,
            id: const Uuid().v4(),
            description: descriptionController.text);
        context.read<TasksBloc>().add(AddTask(task: task));
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fill all the fields')),
      );
    }
  }
}
