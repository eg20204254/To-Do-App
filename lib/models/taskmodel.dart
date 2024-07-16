class Task {
  int? id;
  String title;
  String note;
  DateTime date;
  String startTime;
  String endTime;
  int remind;
  String repeat;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.repeat,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      remind: json['remind'],
      repeat: json['repeat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'repeat': repeat,
    };
  }
}
