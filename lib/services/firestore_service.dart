import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  static final _db = FirebaseFirestore.instance;
  static final _ref = _db.collection("users/test_user/tasks");

  static Future<void> addTask(Task task) async {
    await _ref.doc(task.id).set(task.toMap());
  }

  static Future<void> updateTask(Task task) async {
    await _ref.doc(task.id).update(task.toMap());
  }

  static Future<void> deleteTask(String id) async {
    await _ref.doc(id).delete(); // ✅ use _ref here
  }
}
