import 'package:flutter/material.dart';
import 'package:todoapp/Pages/homePage.dart';
import 'package:todoapp/Pages/taskDetail.dart';
import 'package:todoapp/Widgets/taskContainer.dart';
import 'package:todoapp/controllers/TaskController.dart';
import 'package:todoapp/models/TaskModel.dart';
import 'package:get/get.dart';

class AllTasksPage extends StatelessWidget {
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: buildTaskList(),
    );
  }

  Widget buildTaskList() {
    return Obx(() {
      return ListView.builder(
        itemCount: taskController.taskList.length,
        itemBuilder: (context, index) {
          Task task = taskController.taskList[index];
          return GestureDetector(
            onTap: () => Get.to(TaskDetailPage(task: task)),
            child: TaskContainer(task: task),
          );
        },
      );
    });
  }
}

AppBar _appBar() {
  return AppBar(
    leading: GestureDetector(
      onTap: () {
        Get.to(HomePage());
      },
      child: const Icon(
        Icons.arrow_back_ios,
        size: 20,
      ),
    ),
    title: const Text(
      'All Tasks',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
