import 'package:flutter/material.dart';

import '../app_config.dart';
import '../models/task_models.dart';
import '../services/hive_db_services.dart';

class MnageTasksCounter extends StatefulWidget {
  const MnageTasksCounter({super.key});

  @override
  State<MnageTasksCounter> createState() => _MnageTasksCounterState();
}

class _MnageTasksCounterState extends State<MnageTasksCounter> {
  final TaskServices _taskServices = TaskServices();

  showCounter(BuildContext context, Task task, countFunction) {
    var alert = AlertDialog(
      title: Text(
        task.title,
        style: Res.textStyleDarkGrey,
      ),
      content: Column(
        children: [
          for (var method in task.taskMethods)
            Row(
              children: <Widget>[
                Text(method.name),
                const SizedBox(
                  width: 10,
                ),
                Text(method.counter.toString()),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      countFunction();
                    },
                    icon: Icon(Icons.add))
              ],
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("done"),
        ),
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _taskServices.getAllTasks();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: tasks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView(
                children: [
                  for (final task in snapshot.data!)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showCounter(context, task, ());
                        },
                        child: Column(
                          children: [
                            Text(task.title),
                            Row(
                              children: [
                                for (var method in task.taskMethods)
                                  Row(
                                    children: <Widget>[
                                      Text(method.name),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(method.counter.toString()),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
