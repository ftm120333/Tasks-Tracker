import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_models.g.dart';

Uuid uuid = const Uuid();

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  String id = uuid.v4();

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
