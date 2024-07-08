import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/button.dart';
import 'package:flutter_application_1/Widgets/input_field.dart';
import 'package:flutter_application_1/themeData.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 AM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25, 30];
  String _selectedRepeat = "None";
  List<String> repeatList = [" None", "Daily", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: headingStyle,
            ),
            InputField(title: 'Title', hint: 'Enter your title'),
            InputField(title: 'Note', hint: 'Enter your note'),
            InputField(
              title: 'Date',
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined,
                      color: Colors.grey),
                  onPressed: () {
                    _getDateFromUser();
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    title: 'Start Time',
                    hint: _startTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromeUser(isStartTime: true);
                        },
                        icon: const Icon(Icons.access_time_filled_outlined,
                            color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputField(
                    title: 'End Time',
                    hint: _endTime,
                    widget: IconButton(
                        onPressed: () {
                          _getTimeFromeUser(isStartTime: false);
                        },
                        icon: const Icon(Icons.access_time_filled_rounded,
                            color: Colors.grey)),
                  ),
                ),
              ],
            ),
            InputField(
              title: "Reminder",
              hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                items: remindList.map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                      value: value.toString(), child: Text(value.toString()));
                }).toList(),
              ),
            ),
            InputField(
              title: "Repeat",
              hint: _selectedRepeat,
              widget: DropdownButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: subtitleStyle,
                underline: Container(
                  height: 0,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRepeat = newValue!;
                  });
                },
                items: repeatList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: subtitleStyle,
                      ));
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(label: "Create Task", onTap: () => null),
              ],
            )
          ],
        )),
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2030));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("It is null or something went wrong");
    }
  }

  _getTimeFromeUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          //_startTime --> 10:30 AM
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}
