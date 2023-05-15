import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatefulWidget {
  final Function addTaskCallback;

  const AddTaskScreen(this.addTaskCallback, {super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTaskTitle = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(
            //     top: 10.0,
            //     bottom: 10.0,
            //     left: 5.0,
            //     right: 5.0,
            //   ),
            // ),
            const Text(
              'Add a New Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  widget.addTaskCallback(newTaskTitle);
                },
                child: const Text('Add')),
          ],
        ),
      ),
    );
  }
}
