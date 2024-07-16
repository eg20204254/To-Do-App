import 'package:todoapp/models/TaskModel.dart';
import 'package:get/get.dart';
import 'package:todoapp/services/ApiService.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;
  var isLoading = true.obs;
  final TaskApiService apiService = TaskApiService();

  @override
  void onInit() {
    super.onInit();

    /*taskList.add(Task(
        title: "Task 1",
        note: "This is Task 1",
        date: DateTime.now(),
        startTime: "10:00 AM",
        endTime: "11:00 AM",
        remind: 10,
        repeat: 'None'));
    taskList.add(Task(
        title: "Task 2",
        note: "This is Task 2",
        date: DateTime.now(),
        startTime: "12:00 PM",
        endTime: "1:00 PM",
        remind: 10,
        repeat: 'Daily'));
    taskList.add(Task(
        title: "Task 3",
        note: "This is Task 3",
        date: DateTime.now().add(Duration(days: 1)),
        startTime: "12:00 PM",
        endTime: "1:00 PM",
        remind: 10,
        repeat: 'Daily'));*/

    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading(true);
      var tasks = await apiService.fetchTasks();
      taskList.assignAll(tasks);
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> createTask(Task newTask) async {
    try {
      var createdTask = await apiService.createTask(newTask);
      taskList.add(createdTask);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      var index = taskList.indexWhere((task) => task.id == updatedTask.id);
      if (index != -1) {
        await apiService.updateTask(updatedTask);
        taskList[index] = updatedTask;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      await apiService.deleteTask(taskId);
      taskList.removeWhere((task) => task.id == taskId);
      update();
      taskList.refresh();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> completeTask(int taskId) async {
    try {
      await apiService.completeTask(taskId);
      var task = taskList.firstWhere((task) => task.id == taskId);
      task.isCompleted = true;
      taskList.refresh();
    } catch (e) {
      print("Failed to complete task: $e");
    }
  }
}
