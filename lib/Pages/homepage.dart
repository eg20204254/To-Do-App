import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/addtaskpage.dart';
import 'package:flutter_application_1/Pages/taskDetail.dart';
import 'package:flutter_application_1/Widgets/button.dart';
import 'package:flutter_application_1/Widgets/taskcontainer.dart';
import 'package:flutter_application_1/controllers/taskcontroller.dart';
import 'package:flutter_application_1/themeData.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/taskmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTasks(),
        ],
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                )
              ],
            ),
          ),
          Button(label: "+ Add Task", onTap: () => Get.to(AddTaskPage()))
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color.fromARGB(255, 50, 54, 112),
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
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
      }),
    );
  }
}
