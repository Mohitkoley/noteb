import 'package:flutter/material.dart';
import 'package:noteb/blocs/bloc_export.dart';
import 'package:noteb/model/task.dart';
import 'package:uuid/uuid.dart';

class EditTaskScreen extends StatefulWidget {
  Task oldTask;
  EditTaskScreen({Key? key, required this.oldTask}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.oldTask.title;
    description = widget.oldTask.description;
  }

  bool _validate = false;
  static String title = "";
  static String description = "";
  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController(text: title);
  TextEditingController descriptionController =
      TextEditingController(text: description);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Text("Edit Task", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
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
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: TextFormField(
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
                  child: const Text("Save")),
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
            date: DateTime.now().toString(),
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
