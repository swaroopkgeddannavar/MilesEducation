import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/home/data/model/task_model.dart';

class TaskService {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  TaskService({required this.firestore, required this.auth});

  CollectionReference get _taskCollection => firestore.collection('tasks');

  Stream<List<Task>> getTasks() {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      return Stream.value([]);
    }

    return _taskCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Task.fromJson({
          ...data,
          'id': doc.id,
        });
      }).toList();
    });
  }

  Future<void> addTask(Task task) async {
    final docRef = _taskCollection.doc();
    final taskWithId = task.copyWith(id: docRef.id);
    await docRef.set(taskWithId.toJson());
  }

  Future<void> updateTask(Task task) async {
    if (task.id.isEmpty) throw ArgumentError("Task ID cannot be empty");
    await _taskCollection.doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String id) async {
    if (id.isEmpty) throw ArgumentError("Document ID is required for deletion");
    await _taskCollection.doc(id).delete();
  }
}
