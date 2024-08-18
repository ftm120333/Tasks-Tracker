import 'package:flutter/material.dart';

import '../models/task_models.dart';
import '../services/hive_db_services.dart';
import 'add_task_widget.dart';
import 'alart_dialog.dart';
import 'drawer.dart';
import 'mangage_tasks.dart';

class TaskList extends StatefulWidget {
  TaskList({super.key});

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
    setState(() {
      _tasks = _taskServices.getAllTasks();
    });
  }

  void _deleteTask(int id) async {
    await _taskServices.deleteTask(id);
    _loadTasks(); // Reload the tasks after deletion
  }

  void addTask(task) async {
    await _taskServices.addTask(task);
    _loadTasks(); // Reload the tasks after deletion
  }

  @override
  Widget build(BuildContext context) {
    //final tasks = ref.watch(taskProvider);
    final tasks = _taskServices.getAllTasks();
    var size = MediaQuery.of(context).size;
    print(tasks);
    return Scaffold(
      drawer: const TaskDrawer(),
      appBar: AppBar(),
      body: Column(
        children: [
          AddTask(addTask: addTask),
          SizedBox(
            height: size.height * 0.01,
          ),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: _tasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
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
                              "are you sure you want to delete this task?",
                              () => _deleteTask(index));
                          //_deleteTask(index);
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No tasks found'),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManageTasksCounter(),
            ),
          );
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final String title;
  final Function() onDelete;

  const TaskTile({
    Key? key,
    required this.title,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(12.0),
        leading: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete, color: Colors.redAccent),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
