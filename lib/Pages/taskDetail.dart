import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/taskmodel.dart';
import 'package:intl/intl.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              task.note,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "Start Time: ${task.startTime}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "End Time: ${task.endTime}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Date: ${DateFormat.yMMMd().format(task.date)}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
