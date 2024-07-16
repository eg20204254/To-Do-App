import 'package:flutter/material.dart';
import 'package:todoapp/Pages/homePage.dart';
//import 'package:flutter_application_1/Pages/taskDetail.dart';
import 'package:todoapp/Widgets/button.dart';
import 'package:todoapp/Widgets/inputField.dart';
import 'package:todoapp/controllers/TaskController.dart';
import 'package:todoapp/models/TaskModel.dart';
import 'package:todoapp/themeData.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  final _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate;
  late String _startTime;
  late String _endTime;
  late int _selectedRemind;
  List<int> remindList = [5, 10, 15, 20, 25, 30];
  late String _selectedRepeat;
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  final TaskController taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _noteController = TextEditingController(text: widget.task.note);
    _selectedDate = widget.task.date;
    _startTime = widget.task.startTime;
    _endTime = widget.task.endTime;
    _selectedRemind = widget.task.remind;
    _selectedRepeat = widget.task.repeat;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Task',
                  style: headingStyle,
                ),
                InputField(
                  title: 'Title',
                  hint: 'Enter your title',
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                ),
                InputField(
                  title: 'Note',
                  hint: 'Enter your note',
                  controller: _noteController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Note cannot be empty';
                    }
                    return null;
                  },
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon:
                        Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    onPressed: () {
                      _getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: const Icon(Icons.access_time_filled_outlined,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(
                          onPressed: () {
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: const Icon(Icons.access_time_filled_rounded,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                  title: "Reminder",
                  hint: "$_selectedRemind minutes early",
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitleStyle,
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
                InputField(
                  title: "Repeat",
                  hint: _selectedRepeat,
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                    iconSize: 32,
                    elevation: 4,
                    style: subtitleStyle,
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: subtitleStyle,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button(
                      label: "Update Task",
                      onTap: () {
                        _updateTask();
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

  void _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(widget.task.date)
          : TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        String formattedTime = pickedTime.format(context);
        if (isStartTime) {
          _startTime = formattedTime;
        } else {
          _endTime = formattedTime;
        }
      });
    }
  }

  void _updateTask() async {
    if (_formKey.currentState!.validate()) {
      Task updatedTask = Task(
        id: widget.task.id,
        title: _titleController.text,
        note: _noteController.text,
        date: _selectedDate,
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      );

      try {
        await taskController.updateTask(updatedTask);
        Get.to(() => HomePage());
      } catch (e) {
        print("Failed to update task: $e");
        // Handle error or display error message
      }
    }
  }
}
