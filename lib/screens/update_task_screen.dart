import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithprovider/models/task_notifier.dart';

import '../models/task.dart';

// ignore: must_be_immutable
class UpdateTaskScreen extends StatefulWidget {
  final Function addTaskCallback;
  final Task task;

  const UpdateTaskScreen(this.addTaskCallback, this.task, {super.key});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  // ignore: unused_field
  late TextEditingController _controller = TextEditingController();
  late Task _task;
  late String updatedTask;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
    _controller = TextEditingController(text: _task.task);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskNotifier>(
      builder: (context, taskData, child) => Container(
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
                'Update the Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700),
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                controller: _controller,
              ),
              ElevatedButton(
                onPressed: () {
                  print(_controller.text);
                  _task.task = _controller.text;
                  taskData.updateTask(_task);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task Updated'),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
