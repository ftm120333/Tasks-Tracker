import 'package:hive/hive.dart';

part "task_models.g.dart";

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(1)
  String title;

  @HiveField(2)
  List<Method> taskMethods;

  Task({required this.title, required this.taskMethods});
}

@HiveType(typeId: 2)
class Method {
  @HiveField(0)
  String name;

  @HiveField(1)
  int counter;
  Method({required this.name, required this.counter});
}
