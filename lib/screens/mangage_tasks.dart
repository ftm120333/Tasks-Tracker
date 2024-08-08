import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'package:share_extend/share_extend.dart';


import 'package:path_provider/path_provider.dart';

import '../app_config.dart';
import '../models/task_models.dart';
import '../services/hive_db_services.dart';

import 'alart_dialog.dart';

class ManageTasksCounter extends StatefulWidget {
  const ManageTasksCounter({super.key});

  @override
  State<ManageTasksCounter> createState() => _ManageTasksCounterState();
}

class _ManageTasksCounterState extends State<ManageTasksCounter> {
  final TaskServices _taskServices = TaskServices();
  int counter = 0;

  void _addFixedTasks() async {
    List<String> fixedTasks = [
      "Account Modify", "Wifi Support",
      "New Account", "Custody Service",
      "Password Service", "Other Requires"
    ];

    // Fetch all existing tasks from the Hive box
    List<Task> existingTasks = await _taskServices.getAllTasks();

    // Convert the list of existing tasks to a set of titles
    Set<String> existingTaskTitles = existingTasks.map((task) => task.title).toSet();

    for (var taskTitle in fixedTasks) {
      // Add the task only if it doesn't already exist
      if (!existingTaskTitles.contains(taskTitle)) {
        _taskServices.addTask(Task(
          title: taskTitle,
          taskMethods: [
            Method(name: "call", counter: 0),
            Method(name: "helpDesk", counter: 0),
            Method(name: "itsm", counter: 0),
            Method(name: "email", counter: 0),
          ],
        ));
        setState(() {

        });
      }
    }
  }

  void _resetAllCounters() async {
    List<Task> tasks = await _taskServices.getAllTasks();

    for (var task in tasks) {
      for (var method in task.taskMethods) {
        method.counter = 0;
      }
      // Save the updated task back to the Hive box
      await task.save();
    }
    setState(() {

    });

  }



  void _incrementMethodCounter(int taskKey, Task task, int methodIndex) async {
    // Increment the counter of the specific method
    task.taskMethods[methodIndex].counter++;

    // Save the updated task back to the Hive box
    await _taskServices.updateTask(taskKey, task);

    // Trigger a rebuild to reflect changes
    setState(() {});
  }

  void showCounter(BuildContext context, int taskKey, Task task) {
    var alert = AlertDialog(
      title: Text(
        task.title,
        style: Res.textStyleDarkGrey,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < task.taskMethods.length; i++)
            Row(
              children: <Widget>[
                Text(task.taskMethods[i].name),
                const SizedBox(width: 10),
                Text(task.taskMethods[i].counter.toString()),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    _incrementMethodCounter(taskKey, task, i);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Done"),
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
  void initState() {
    super.initState();
    _addFixedTasks();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Tasks Counter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: (){
              showLoaderVersionAlart(
                  context,
                  "Reset counters",
                  "are you sure you want to reset the counters?",
                  () => _resetAllCounters());
            }
            // Reset all counters
          ),
        ],
      ),
      body: FutureBuilder(
        future: _taskServices.getAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final taskKey = task.key as int;  // Fetch the key from the task

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showCounter(context, taskKey, task);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title),
                        Row(
                          children: [
                            for (var method in task.taskMethods)
                              Row(
                                children: <Widget>[
                                  Text(method.name),
                                  const SizedBox(width: 10),
                                  Text(method.counter.toString()),
                                  const SizedBox(width: 10),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createAndShareExcel(_taskServices.getAllTasks());
        },
        child: const Icon(Icons.table_chart),
      ),
    );
  }




  Future<void> createAndShareExcel(tasks) async {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];
    // Adding header row
    sheet.appendRow(["Task Name", "Counter"] as List<CellValue?>);

    // Adding tasks data
    for (var task in tasks) {
      sheet.appendRow([task.name, task.counter]);
    }
    // Save the Excel file
    final excelBytes = excel.save();
    final excelFilePath = '${(await getTemporaryDirectory()).path}/taskCounter.xlsx';
    final excelFile = File(excelFilePath)..writeAsBytesSync(excelBytes!);

    // Share the Excel file using the share_extend package
    await ShareExtend.share(excelFile.path, 'file', subject: "Task counter",
        extraText: "These are the task counters for this month");
  }




}


