import 'package:flutter/material.dart';
import 'package:lecture_four/Models/Task.dart';
import 'package:lecture_four/Routes/Routes_name.dart';
import 'package:lecture_four/Screens/Add_Task_Screen.dart';
import 'package:lecture_four/Screens/View_Task_Screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.viewTask:
        return MaterialPageRoute(builder: (_) => const ViewTaskScreen());
      case RouteNames.addTask:
        final task = settings.arguments as Task?;
        return MaterialPageRoute(
          builder: (_) => AddTaskScreen(existingTask: task),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
