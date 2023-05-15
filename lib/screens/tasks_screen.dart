import 'package:flutter/material.dart';
import 'package:todowithprovider/screens/add_task_screen.dart';
import 'package:provider/provider.dart';
import '../models/task_notifier.dart';
import '../widgets/tasks_list.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Provider.of<TaskNotifier>(context, listen: false).readTask();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskNotifier>(
      builder: (context, taskData, child) => Scaffold(
        drawer: Drawer(
          child: ListView(
            children: const [
              ListTile(
                title: Text('Hello'),
              ),
              ListTile(
                title: Text('Bello'),
              ),
            ],
          ),
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.lightBlueAccent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen((newTaskTitle) {
                taskData.addTask(newTaskTitle);

                Navigator.pop(context);
              }),
            );
          },
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(
            Icons.add,
            size: 30.0,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 60.0, left: 40.0, right: 60.0, bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    // ignore: sort_child_properties_last
                    child: IconButton(
                      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                      icon: const Icon(
                        Icons.list,
                        size: 40.0,
                        color: Colors.lightBlueAccent,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),

                    backgroundColor: Colors.white,
                    radius: 30.0,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'To-Do List App',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.white),
                  ),
                  Text(
                    (taskData.tasks.isNotEmpty)
                        ? '${taskData.taskCounter} Tasks'
                        : '0 Task',
                    style: const TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: (taskData.tasks.isNotEmpty)
                    ? TasksListViewBuilder()
                    : const Center(
                        child: Text(
                          'Create Your First Task...',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
