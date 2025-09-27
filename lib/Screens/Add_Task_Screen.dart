import 'package:flutter/material.dart';
import 'package:lecture_four/Models/Task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, Task? existingTask});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? titleError;
  String? descriptionError;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final task = ModalRoute.of(context)!.settings.arguments as Task?;
    if (task != null) {
      titleController.text = task.title;
      descriptionController.text = task.description;
    }
  }

  void saveTask() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    setState(() {
      titleError = null;
      descriptionError = null;

      if (title.isEmpty) {
        titleError = 'Title is required';
      } else if (title.length > 20) {
        titleError = 'Title must be <= 20 characters';
      }

      if (description.isEmpty) {
        descriptionError = 'Description is required';
      }
    });

    if (titleError == null && descriptionError == null) {
      final task = Task(title: title, description: description);
      Navigator.pop(context, task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add / Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                errorText: titleError,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                errorText: descriptionError,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: saveTask, child: const Text('Save Task')),
          ],
        ),
      ),
    );
  }
}
