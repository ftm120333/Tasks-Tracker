import 'package:hive_flutter/hive_flutter.dart';

import '../models/task_models.dart';

class TaskServices {
  final String _boxName = "tasksBox";

  Future<Box<Task>> get _box async => await Hive.openBox<Task>(_boxName);

//create
  Future<void> addTask(Task task) async {
    var box = await _box;
    await box.add(task);
  }

//read
  Future<List<Task>> getAllTasks() async {
    var box = await _box;
    return box.values.toList();
  }

//update
  Future<void> updateTask(int id, Task task) async {
    var box = await _box;
    await box.putAt(id, task);
  }

//delete
  Future<void> deleteTask(int id) async {
    var box = await _box;
    await box.deleteAt(id);
  }
}
