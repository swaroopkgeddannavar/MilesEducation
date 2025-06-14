import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/services/fire_store_services.dart';
import '../../data/model/task_model.dart';

class TaskController extends GetxController {
  final TaskService service;

  TaskController({required this.service});

  final tasks = <Task>[].obs;
  final isLoading = false.obs;

  final title = ''.obs;
  final description = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tasks.bindStream(service.getTasks());
  }

  Future<void> addTask() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (title.isNotEmpty && description.isNotEmpty && userId != null) {
      await service.addTask(
        Task(
          id: '',
          title: title.value,
          description: description.value,
          userId: userId,
        ),
      );
      clearFields();
    }
  }

  Future<void> updateTask(Task task) async {
    if (task.id.isEmpty) {
      Get.snackbar("Error", "Task ID is missing. Cannot update task.");
      return;
    }

    await service.updateTask(task);
  }


  Future<void> deleteTask(String id) async {
    await service.deleteTask(id);
  }

  void clearFields() {
    title.value = '';
    description.value = '';
  }
}
