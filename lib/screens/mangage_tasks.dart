import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:task_counter/screens/task_item_widget.dart';

import '../app_config.dart';
import '../models/task_models.dart';
import '../services/hive_db_services.dart';
import 'alart_dialog.dart';
import 'drawer.dart';

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
      "Account Modify",
      "Wifi Support",
      "New Account",
      "Custody Service",
      "Password Service",
      "Other Requires"
    ];

    // Fetch all existing tasks from the Hive box
    List<Task> existingTasks = await _taskServices.getAllTasks();

    // Convert the list of existing tasks to a set of titles
    Set<String> existingTaskTitles =
        existingTasks.map((task) => task.title).toSet();

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
        setState(() {});
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _addFixedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const TaskDrawer(),
      appBar: AppBar(
        title: Text(
          'Manage Tasks Counter',
          style: Res.titleStyle,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
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
            return Center(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final taskKey = task.key as int;

                  return TaskItemWidget(
                    task: task,
                    taskKey: taskKey,
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Res.whiteColor,
        onPressed: () {
          createAndShareExcel();
        },
        child: Icon(
          Icons.table_chart,
          color: Res.kPrimaryColor,
        ),
      ),
    );
  }

  //This function is to create an excel data of the task counters
  Future<void> createAndShareExcel() async {
    //get data from Hive DB
    List<Task> tasks = await _taskServices.getAllTasks();
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];
    // Creating the header row
    var headers = <String>['Task Name'];
    if (tasks.isNotEmpty) {
      // Collect method names for header if available
      var methodNames = <String>{};
      for (var task in tasks) {
        for (var method in task.taskMethods) {
          methodNames.add(method.name);
        }
      }
      headers.addAll(methodNames);
    }
    sheet.appendRow(headers.map((header) => TextCellValue(header)).toList());

    // Adding tasks data
    for (var task in tasks) {
      // Create a list of cell values starting with the task title
      var row = <CellValue>[TextCellValue(task.title)];

      var methodCounterMap = {
        for (var method in task.taskMethods) method.name: method.counter
      };

      for (var header in headers.skip(1)) {
        // Skip the first header as it is "Task Name"
        row.add(IntCellValue(methodCounterMap[header] ??
            0)); // Add counter or 0 if method not present
      }

      sheet.appendRow(row);
    }

    // Save the Excel file
    final excelBytes = excel.save();
    final excelFilePath =
        '${(await getTemporaryDirectory()).path}/taskCounter.xlsx';
    final excelFile = File(excelFilePath)..writeAsBytesSync(excelBytes!);
    DateTime today = DateTime.now();
    // Share the Excel file using the share_extend package
    await ShareExtend.share(excelFile.path, 'file',
        subject: "Task counter",
        extraText: "These are the task counters for $today");
  }
}
