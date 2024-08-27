import 'package:flutter/material.dart';
import 'package:task_counter/screens/tasks_manager.dart';

import '../../app_config.dart';
import '../about.dart';
import '../task_counters.dart';

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
                'Tasks Tracker',
                style: Res.textStyleNormalWhiteLLS,
              ),
              const SizedBox(
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
        title: const Text('Tasks dashboard'),
        leading: const Icon(Icons.home),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const ManageTasksCounter();
          }));
        },
      ),
      ListTile(
        leading: const Icon(Icons.add_outlined),
        title: const Text('Manage Tasks'),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return TaskList();
          }));
        },
      ),
      ListTile(
        leading: const Icon(Icons.info_outline),
        title: const Text('About'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AboutTheApp();
          }));
        },
      ),
    ]));
  }
}
