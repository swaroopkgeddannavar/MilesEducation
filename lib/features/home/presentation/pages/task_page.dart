import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth/presentaion/controllers/login_controller.dart';
import '../../data/model/task_model.dart';
import '../controll/task_controller.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          "📝 Task Manager",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Get.defaultDialog(
                  title: "Confirm Logout",
                  middleText: "Are you sure you want to logout?",
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.find<LoginController>().logout();
                    Get.back();
                  },
                );
              },

              tooltip: 'Logout',
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.tasks.isEmpty) {
          return const Center(
            child: Text(
              "No tasks found.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.tasks.length,
          itemBuilder: (_, index) {
            final task = controller.tasks[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                title: Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    task.description,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueAccent),
                      tooltip: "Edit",
                      onPressed: () {
                        titleController.text = task.title;
                        descController.text = task.description;

                        Get.defaultDialog(
                          title: 'Edit Task',
                          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                          content: Column(
                            children: [
                              TextField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: descController,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                          textConfirm: 'Update',
                          textCancel: 'Cancel',
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            if (titleController.text.trim().isEmpty || descController.text.trim().isEmpty) {
                              Get.closeCurrentSnackbar();
                              Get.snackbar(
                                "Error",
                                "Both Title and Description are required!",
                                backgroundColor: Colors.orangeAccent,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else {
                              controller.updateTask(
                                Task(
                                  id: task.id,
                                  title: titleController.text.trim(),
                                  description: descController.text.trim(), userId: task.userId,
                                ),
                              );
                              Get.back();
                            }
                          },

                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      tooltip: "Delete",
                      onPressed: () => controller.deleteTask(task.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.title.value = '';
          controller.description.value = '';

          Get.defaultDialog(
            title: "Add Task",
            titleStyle: const TextStyle(fontWeight: FontWeight.bold),
            content: Column(
              children: [
                TextField(
                  onChanged: (val) => controller.title.value = val,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (val) => controller.description.value = val,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            textConfirm: 'Add',
            textCancel: 'Cancel',
            confirmTextColor: Colors.white,
            onConfirm: () {
              if (controller.title.value.trim().isEmpty || controller.description.value.trim().isEmpty) {
                Get.closeCurrentSnackbar();
                Get.snackbar(
                  "Error",
                  "Both Title and Description are required!",
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                controller.addTask();
                Get.back();
              }
            },

          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
