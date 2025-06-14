import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/home/data/model/task_model.dart';


class TaskService {
  final CollectionReference taskCollection =
  FirebaseFirestore.instance.collection('tasks');

  // Create
  Future<void> addTask(Task task) async {
    await taskCollection.add(task.toMap());
  }

  // Read
  Stream<List<Task>> getTasks() {
    return taskCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Update
  Future<void> updateTask(Task task) async {
    await taskCollection.doc(task.id).update(task.toMap());
  }

  // Delete
  Future<void> deleteTask(String taskId) async {
    await taskCollection.doc(taskId).delete();
  }
}
