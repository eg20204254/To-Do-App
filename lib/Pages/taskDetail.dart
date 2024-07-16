import 'package:flutter/material.dart';
import 'package:todoapp/Pages/allTaskspage.dart';
import 'package:todoapp/Pages/editTaskpage.dart';
import 'package:todoapp/controllers/TaskController.dart';
import 'package:todoapp/models/TaskModel.dart';
import 'package:todoapp/themeData.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Details',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Color.fromARGB(255, 50, 54, 112),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 50, 54, 112),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  task.note,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color.fromARGB(255, 50, 54, 112)),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            getIcon(Icons.calendar_today),
                            SizedBox(width: 8),
                            Text(
                              "Date:",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            getIcon(Icons.access_time),
                            SizedBox(width: 8),
                            Text(
                              "Start Time:",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            getIcon(Icons.access_time_outlined),
                            SizedBox(width: 8),
                            Text(
                              "End Time:",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            getIcon(Icons.notifications),
                            SizedBox(width: 8),
                            Text(
                              "Reminder:",
                              style: fontStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            getIcon(Icons.repeat),
                            SizedBox(width: 8),
                            Text(
                              "Repeat:",
                              style: fontStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${DateFormat.yMMMd().format(task.date)}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          task.startTime,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          task.endTime,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${task.remind} minutes before",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          task.repeat,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Spacer(), // Spacer to push the bottom bar to the bottom
                const Divider(color: Color.fromARGB(255, 50, 54, 112)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit,
                          color: Color.fromARGB(255, 0, 0, 0)),
                      onPressed: () => Get.to(EditTaskPage(task: task)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Color.fromARGB(255, 164, 10, 10)),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, taskController);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.check_circle,
                          color: Color.fromARGB(255, 7, 24, 123)),
                      onPressed: () {
                        _showCompleteConfirmationDialog(
                            context, taskController);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, TaskController taskController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Delete Task",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
          content: const Text("Are you sure you want to delete this Task?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 9, 1, 64),
                ),
                child: const Center(
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onPressed: () {
                _deleteTask(taskController);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(TaskController taskController) {
    if (task.id != null) {
      taskController.deleteTask(task.id!);
      Get.snackbar(
        "Success",
        "Task successfully deleted",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Delay before navigating to ensure the snackbar is shown
      Future.delayed(Duration(seconds: 1), () {
        Get.offAll(() => AllTasksPage());
      });
    } else {
      Get.snackbar(
        "Error",
        "Task ID is null",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _showCompleteConfirmationDialog(
      BuildContext context, TaskController taskController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Complete Task",
            style: TextStyle(
              color: Color.fromARGB(255, 7, 24, 123),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text("Are you complete this Task?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 9, 1, 64),
                ),
                child: const Center(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onPressed: () {
                _completeTask(taskController);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _completeTask(TaskController taskController) {
    if (task.id != null) {
      taskController.completeTask(task.id!);
      Get.snackbar(
        "Success",
        "Task completed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Delay before navigating to ensure the snackbar is shown
      Future.delayed(Duration(seconds: 1), () {
        Get.back();
      });
    } else {
      Get.snackbar(
        "Error",
        "Task ID is null",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
