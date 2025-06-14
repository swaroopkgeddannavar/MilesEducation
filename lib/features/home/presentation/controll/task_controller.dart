import 'package:get/get.dart';

import '../../../../core/services/fire_store_services.dart';
import '../../data/model/task_model.dart';


class TaskController extends GetxController {
  final TaskService _service = TaskService();

  final tasks = <Task>[].obs;
  final isLoading = false.obs;

  final title = ''.obs;
  final description = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tasks.bindStream(_service.getTasks());
  }

  Future<void> addTask() async {
    if (title.isNotEmpty && description.isNotEmpty) {
      await _service.addTask(Task(id: '', title: title.value, description: description.value));
      clearFields();
    }
  }

  Future<void> updateTask(Task task) async {
    await _service.updateTask(task);
  }

  Future<void> deleteTask(String id) async {
    await _service.deleteTask(id);
  }

  void clearFields() {
    title.value = '';
    description.value = '';
  }
}
