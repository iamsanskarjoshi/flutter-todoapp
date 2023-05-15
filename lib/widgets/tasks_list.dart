import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todowithprovider/widgets/tasks_tile.dart';

import '../models/task_notifier.dart';
import '../screens/update_task_screen.dart';

// ignore: use_key_in_widget_constructors
class TasksListViewBuilder extends StatefulWidget {
  @override
  State<TasksListViewBuilder> createState() => _TasksListViewBuilderState();
}

class _TasksListViewBuilderState extends State<TasksListViewBuilder> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskNotifier>(context, listen: false).readTask();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskNotifier>(
      builder: (context, taskData, child) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: taskData.tasks.length,
        itemBuilder: (context, index) {
          final task = taskData.tasks[index];

          return TaskListTile(
            taskTitle: task.task,
            isChecked: task.isTaskDone,
            checkboxCallback: (checkboxState) {
              taskData.updateCheckBox(task);
            },
            deleteUpdateCallback: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text(task.task),
                        content: const Text(
                            'You want to Update or Delete this task?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => UpdateTaskScreen(() {
                                  Navigator.pop(context);
                                }, task),
                              );
                            },
                            child: const Text('Update'),
                          ),
                          TextButton(
                            onPressed: () {
                              taskData.deleteTask(task);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Task Deleted'),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ));
            },
          );
        },
      ),
    );
  }
}
