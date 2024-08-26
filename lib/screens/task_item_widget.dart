import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../app_config.dart';
import '../models/task_models.dart'; // Update with your actual path

class TaskItemWidget extends StatefulWidget {
  final Task task;
  final int taskKey;

  const TaskItemWidget({
    Key? key,
    required this.task,
    required this.taskKey,
  }) : super(key: key);

  @override
  _TaskItemWidgetState createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  bool _isExpanded = false;

  void _updateTaskInHive() async {
    final box = await Hive.openBox<Task>('tasksBox');
    await box.put(widget.taskKey, widget.task);
  }

  void _incrementMethodCounter(int index) {
    setState(() {
      widget.task.taskMethods[index].counter++;
    });
    _updateTaskInHive();
  }

  void _decrementMethodCounter(int index) {
    setState(() {
      if (widget.task.taskMethods[index].counter > 0) {
        widget.task.taskMethods[index].counter--;
      }
    });
    _updateTaskInHive();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Res.kPrimaryColor, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_isExpanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.task.taskMethods.asMap().entries.map((entry) {
                    final i = entry.key;
                    final method = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color:
                            Res.whiteColor.withOpacity(0.7), // Background color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            method.name,
                            style: TextStyle(color: Res.kPrimaryColor),
                          ),
                          Text(
                            method.counter.toString(),
                            style: TextStyle(color: Res.kPrimaryColor),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _decrementMethodCounter(i),
                                icon: Icon(Icons.remove,
                                    color: Res.kPrimaryColor),
                              ),
                              IconButton(
                                onPressed: () => _incrementMethodCounter(i),
                                icon: Icon(Icons.add, color: Res.kPrimaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8.0),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
