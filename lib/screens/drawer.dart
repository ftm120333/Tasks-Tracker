import 'package:flutter/material.dart';
import 'package:task_counter/screens/task_list.dart';

import '../app_config.dart';
import 'mangage_tasks.dart';

class TaskDrawer extends StatelessWidget {
  const TaskDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Res.kPrimaryColor,
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                'Manage Tasks Counter',
                style: Res.textStyleNormalWhiteLLS,
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                Res.appIcon,
                width: 50,
              )
            ],
          ),
        ),
      ),
      ListTile(
        title: const Text('tasks dashboard'),
        leading: Icon(Icons.home),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const ManageTasksCounter();
          }));
        },
      ),
      ListTile(
        leading: Icon(Icons.add_outlined),
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
