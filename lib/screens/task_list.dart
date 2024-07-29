import 'package:flutter/material.dart';

import '../models/task_models.dart';
import '../services/hive_db_services.dart';
import 'add_task_widget.dart';
import 'mangage_tasks.dart';

class TaskList extends StatelessWidget {
  TaskList({super.key});
  final TaskServices _taskServices = TaskServices();
  @override
  Widget build(BuildContext context) {
    //final tasks = ref.watch(taskProvider);
    final tasks = _taskServices.getAllTasks();
    var size = MediaQuery.of(context).size;
    print(tasks);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          AddTask(),
          SizedBox(
            height: size.height * 0.01,
          ),
          Expanded(
              child: FutureBuilder(
            future: tasks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    for (final task in snapshot.data!)
                      TaskTile(
                        title: task.title,
                        methods: task.taskMethods,
                      ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MnageTasksCounter(),
            ),
          );
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  String title;
  List<Method> methods;

  TaskTile({super.key, required this.title, required this.methods});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        children: [
          Row(
            children: [
              for (var method in methods)
                Row(
                  children: [
                    Text(method.name),
                    SizedBox(
                      width: 10,
                    ),
                    Text(method.counter.toString()),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
