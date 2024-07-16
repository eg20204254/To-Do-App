import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Pages/addTaskpage.dart';
import 'package:todoapp/Pages/allTaskspage.dart';
import 'package:todoapp/Pages/taskDetail.dart';
import 'package:todoapp/Widgets/button.dart';
import 'package:todoapp/Widgets/taskContainer.dart';
import 'package:todoapp/controllers/TaskController.dart';
import 'package:todoapp/themeData.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/models/TaskModel.dart';

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
          addTaskBar(),
          addDateBar(),
          showTasks(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Color.fromARGB(255, 9, 1, 64), // Set the background color
        selectedItemColor:
            Color.fromARGB(255, 121, 114, 241), // Color of the selected item
        unselectedItemColor: Colors.white, // Color of unselected items
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Get.to(AllTasksPage());
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: Color.fromARGB(255, 121, 114, 241),
            ),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
        ],
      ),
    );
  }

  Widget addTaskBar() {
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

  Widget addDateBar() {
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
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  Widget showTasks() {
    return Expanded(
      child: Obx(() {
        var filteredTasks = taskController.taskList.where((task) =>
            task.date.year == _selectedDate.year &&
            task.date.month == _selectedDate.month &&
            task.date.day == _selectedDate.day);

        return ListView.builder(
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            Task task = filteredTasks.elementAt(index);
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
