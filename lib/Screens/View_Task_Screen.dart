import 'package:flutter/material.dart';
import 'package:lecture_four/Helpers/Storage_Helper.dart';
import 'package:lecture_four/Models/Task.dart';
import 'package:lecture_four/Routes/Routes_name.dart';

class ViewTaskScreen extends StatefulWidget {
  const ViewTaskScreen({super.key});

  @override
  _ViewTaskScreenState createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasksFromStorage();
  }

  void loadTasksFromStorage() async {
    final loadedTasks = await StorageHelper.loadTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }

  void goToAddTaskScreen({Task? task, int? index}) async {
    final result = await Navigator.pushNamed(
      context,
      RouteNames.addTask,
      arguments: task,
    );

    if (result != null && result is Task) {
      setState(() {
        if (index != null) {
          tasks[index] = result;
        } else {
          tasks.add(result);
        }
      });
      await StorageHelper.saveTasks(tasks);
    }
  }

  void toggleCheck(int index, bool? value) async {
    setState(() {
      tasks[index].isChecked = value ?? false;
    });
    await StorageHelper.saveTasks(tasks);
  }

  void deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });
    await StorageHelper.saveTasks(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Colors.teal,
      ),
      body: tasks.isEmpty
          ? const Center(child: Text("No tasks yet, click + to add"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isChecked,
                      onChanged: (value) => toggleCheck(index, value),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            task.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: task.isFavourite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              task.isFavourite = !task.isFavourite;
                              StorageHelper.saveTasks(tasks);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () =>
                              goToAddTaskScreen(task: task, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteTask(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToAddTaskScreen(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
