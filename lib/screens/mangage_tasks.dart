import 'package:flutter/material.dart';

import '../services/hive_db_services.dart';

class MnageTasksCounter extends StatefulWidget {
  const MnageTasksCounter({super.key});

  @override
  State<MnageTasksCounter> createState() => _MnageTasksCounterState();
}

class _MnageTasksCounterState extends State<MnageTasksCounter> {
  final TaskServices _taskServices = TaskServices();

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
                        onPressed: () {},
                        child: Column(
                          children: [
                            Text(task.title),
                            Row(
                              children: [
                                for (var method in task.taskMethods)
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
