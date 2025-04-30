// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../services/voice_service.dart';

class HomeScreen extends ConsumerWidget {
  final uuid = Uuid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voice To-Do',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'No tasks yet. Tap the mic to add one!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.completed,
                      onChanged: (_) =>
                          ref.read(taskProvider.notifier).toggleTask(task.id),
                      activeColor: Colors.teal,
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        decoration: task.completed
                            ? TextDecoration.lineThrough
                            : null,
                        color: task.completed ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final command = await VoiceService.listen();
          if (command != null && command.trim().isNotEmpty) {
            final task = Task(id: uuid.v4(), title: command);
            ref.read(taskProvider.notifier).addTask(task);
          }
        },
        backgroundColor: Colors.teal,
        tooltip: 'Add Task via Voice using To-do assistant',
        child: Icon(Icons.mic),
      ),
    );
  }
}
