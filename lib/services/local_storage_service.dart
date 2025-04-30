import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';

class LocalStorageService {
  static late Box<Task> _taskBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    _taskBox = await Hive.openBox<Task>('offline_tasks');
  }

  static Future<void> queueTask(Task task) async {
    await _taskBox.put(task.id, task);
  }

  static Future<List<Task>> getQueuedTasks() async {
    return _taskBox.values.toList();
  }

  static Future<void> removeTask(String id) async {
    await _taskBox.delete(id);
  }

  static Future<void> updateTask(Task updated) async {
    await _taskBox.put(updated.id, updated);
  }

  static Future<void> clear() async {
    await _taskBox.clear();
  }
}
