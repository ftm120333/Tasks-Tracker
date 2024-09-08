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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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
                  const SizedBox(height: 10),
                  Image.asset(
                    Res.appIcon,
                    width: 50,
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(
            context,
            title: 'Tasks Dashboard',
            icon: Icons.home,
            onTap: () => _navigateTo(context, const ManageTasksCounter()),
          ),
          _buildDrawerItem(
            context,
            title: 'Manage Tasks',
            icon: Icons.add_outlined,
            onTap: () => _navigateTo(context, const TaskList()),
          ),
          _buildDrawerItem(
            context,
            title: 'About',
            icon: Icons.info_outline,
            onTap: () => _navigateTo(context, const AboutTheApp()),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _navigateTo(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}
