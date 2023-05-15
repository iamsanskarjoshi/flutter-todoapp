// import 'dart:convert';

// Task taskFromMap(String str) => Task.fromMap(json.decode(str));

// String taskToMap(Task data) => json.encode(data.toMap());

// class Task {
//   Task({
//     required this.task,
//     this.isTaskDone = false,
//   });

//   String task;
//   bool isTaskDone;
//
//   factory Task.fromMap(Map<String, dynamic> map) => Task(
//         task: map["task"],
//       );

//   Map<String, dynamic> toMap() => {
//         "task": task,
//       };
// }
// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

Task taskFromJson(String str) => Task.fromMap(json.decode(str));

String taskToJson(Task data) => json.encode(data.toMap());

class Task {
  Task({
    required this.task,
    this.isTaskDone = false,
    required this.id,
  });

  String task;
  bool isTaskDone;
  int? id;
  void isToggleDone() {
    isTaskDone = !(isTaskDone);
  }

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        task: map["task"],
        id: map["id"],
      );

  Map<String, dynamic> toMap() => {
        "task": task,
        "id": id,
      };
}
