import 'package:flutter/material.dart';
import 'package:lecture_four/Screens/Add_Task_Screen.dart';
import 'package:lecture_four/Screens/View_Task_Screen.dart';
import 'routes/Routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.viewTask,
      routes: {
        RouteNames.viewTask: (context) => const ViewTaskScreen(),
        RouteNames.addTask: (context) => const AddTaskScreen(),
      },
    );
  }
}
