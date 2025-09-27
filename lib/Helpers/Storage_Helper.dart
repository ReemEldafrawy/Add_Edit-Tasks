import 'package:lecture_four/Models/Task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageHelper {
  static const String _taskKey = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson = tasks.map((task) => task.toJson()).toList();
    prefs.setString(_taskKey, jsonEncode(taskListJson));
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_taskKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded.map((item) => Task.fromJson(item)).toList();
  }
}
