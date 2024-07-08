class Task {
  String title;
  String note;
  DateTime date;
  String startTime;
  String endTime;
  int remind;
  String repeat;

  Task(
      {required this.title,
      required this.note,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.remind,
      required this.repeat});
}
