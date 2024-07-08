import 'package:flutter_application_1/models/taskmodel.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var taskList = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Adding some sample data
    taskList.add(Task(
        title: "Task 1",
        note: "This is task 1",
        date: DateTime.now(),
        startTime: "10:00 AM",
        endTime: "11:00 AM",
        remind: 10,
        repeat: 'None'));
    taskList.add(Task(
        title: "Task 2",
        note: "This is task 2",
        date: DateTime.now(),
        startTime: "12:00 PM",
        endTime: "1:00 PM",
        remind: 10,
        repeat: 'Daily'));
  }
}
