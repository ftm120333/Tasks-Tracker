import 'package:flutter/material.dart';

import '../app_config.dart';
import '../models/task_models.dart';
import '../services/hive_db_services.dart';
import 'components/add_task_widget.dart';
import 'components/alart_dialog.dart';
import 'components/drawer.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TaskServices _taskServices = TaskServices();
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    _tasks = _taskServices.getAllTasks();
  }

  Future<void> _deleteTask(int id) async {
    try {
      await _taskServices.deleteTask(id);
      _loadTasks();
      setState(() {}); // Trigger UI update after loading tasks
    } catch (e) {
      // Handle errors here
      print('Error deleting task: $e');
    }
  }

  Future<void> _addTask(Task task) async {
    try {
      await _taskServices.addTask(task);
      _loadTasks();
      setState(() {}); // Trigger UI update after loading tasks
    } catch (e) {
      // Handle errors here
      print('Error adding task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const TaskDrawer(),
      appBar: AppBar(
        title: const Text("Task Manager"),
      ),
      body: Column(
        children: [
          AddTask(addTask: _addTask),
          SizedBox(height: size.height * 0.01),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: _tasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No tasks found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final task = snapshot.data![index];
                      return TaskTile(
                        title: task.title,
                        onDelete: () {
                          showLoaderVersionAlart(
                            context,
                            "Deleting Task",
                            "Are you sure you want to delete this task?",
                            () => _deleteTask(index),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final String title;
  final Function() onDelete;

  const TaskTile({
    super.key,
    required this.title,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Res.ddGrayColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: IconButton(
          onPressed: onDelete,
          icon: Icon(Icons.delete, color: Res.sPrimaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
