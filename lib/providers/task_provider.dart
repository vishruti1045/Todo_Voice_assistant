// lib/providers/task_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../services/firestore_service.dart';
import '../services/local_storage_service.dart';
import '../services/tts_service.dart';
import '../utils/connectivity.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) => TaskNotifier());

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void loadTasks(List<Task> tasks) => state = tasks;

  Future<void> addTask(Task task, {bool fromVoice = false}) async {
    state = [...state, task];

    if (await isConnected()) {
      await FirestoreService.addTask(task);
    } else {
      await LocalStorageService.queueTask(task);
    }

    if (fromVoice) {
      TTSService.speak("Task added: ${task.title}");
    }
  }

  Future<void> toggleTask(String id) async {
    final index = state.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final task = state[index];
    task.completed = !task.completed;
    task.updatedAt = DateTime.now();

    if (task.completed) {
      // Remove task from UI and Firestore/localStorage
      state = state.where((t) => t.id != id).toList();

      if (await isConnected()) {
        await FirestoreService.deleteTask(task.id);
      } else {
        await LocalStorageService.removeTask(task.id);
      }

      TTSService.speak("Task completed and removed");
    } else {
      state = [...state]; // Just update UI state

      if (await isConnected()) {
        await FirestoreService.updateTask(task);
      } else {
        await LocalStorageService.updateTask(task);
      }

      TTSService.speak("Marked as pending");
    }
  }
}
