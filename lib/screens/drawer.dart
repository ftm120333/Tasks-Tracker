import 'package:flutter/material.dart';
import 'package:task_counter/screens/task_list.dart';

import 'mangage_tasks.dart';

class TaskDrawer extends StatelessWidget {
  const TaskDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.teal,
        ),
        child: Text('Manage Tasks Counter'),
      ),
      ListTile(
        title: const Text('tasks dashboard'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const ManageTasksCounter();
          }));
        },
      ),
      ListTile(
        title: const Text('manage tasks'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return TaskList();
          }));
        },
      ),
    ]));
  }
}
