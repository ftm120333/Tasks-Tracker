import 'package:flutter/material.dart';

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

  void _incrementMethodCounter(int index) {
    setState(() {
      widget.task.taskMethods[index].counter++;
    });
    // Update your task data here
    // Example: _taskServices.updateTask(widget.taskKey, widget.task);
  }

  void _decrementMethodCounter(int index) {
    setState(() {
      if (widget.task.taskMethods[index].counter > 0) {
        widget.task.taskMethods[index].counter--;
      }
    });
    // Update your task data here
    // Example: _taskServices.updateTask(widget.taskKey, widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal, // Text color
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
                              color: Colors.teal[100], // Background color
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  method.name,
                                  style: TextStyle(color: Colors.teal[900]),
                                ),
                                Text(
                                  method.counter.toString(),
                                  style: TextStyle(color: Colors.teal[900]),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          _decrementMethodCounter(i),
                                      icon: const Icon(Icons.remove,
                                          color: Colors.teal),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          _incrementMethodCounter(i),
                                      icon: const Icon(Icons.add,
                                          color: Colors.teal),
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
          ],
        ),
      ),
    );
  }
}
