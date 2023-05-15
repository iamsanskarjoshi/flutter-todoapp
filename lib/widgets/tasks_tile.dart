import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TaskListTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkboxCallback;
  final Function() deleteUpdateCallback;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  TaskListTile(
      {required this.isChecked,
      required this.taskTitle,
      required this.checkboxCallback,
      required this.deleteUpdateCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: deleteUpdateCallback,
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
