import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../app_config.dart';
import '../../models/task_models.dart'; // Update with your actual path

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

  Future<void> _updateTaskInHive() async {
    try {
      final box = await Hive.openBox<Task>('tasksBox');
      await box.put(widget.taskKey, widget.task);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update task: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _changeMethodCounter(int index, bool increment) {
    setState(() {
      final currentCounter = widget.task.taskMethods[index].counter;
      widget.task.taskMethods[index].counter = increment
          ? currentCounter + 1
          : (currentCounter > 0 ? currentCounter - 1 : 0);
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
          backgroundColor: Res.kPrimaryColor,
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
            if (_isExpanded) ..._buildExpandedContent(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildExpandedContent() {
    return widget.task.taskMethods.asMap().entries.map((entry) {
      final index = entry.key;
      final method = entry.value;
      return Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Res.whiteColor.withOpacity(0.7),
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
                  onPressed: () => _changeMethodCounter(index, false),
                  icon: Icon(Icons.remove, color: Res.kPrimaryColor),
                ),
                IconButton(
                  onPressed: () => _changeMethodCounter(index, true),
                  icon: Icon(Icons.add, color: Res.kPrimaryColor),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }
}
