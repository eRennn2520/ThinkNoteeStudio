import 'package:flutter/material.dart';
import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String time; // HH:mm

  @HiveField(4)
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });
}

/// Manual Hive adapter (no build_runner needed)
class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      title: (fields[0] ?? '') as String,
      description: (fields[1] ?? '') as String,
      date: (fields[2] ?? DateTime.now()) as DateTime,
      time: (fields[3] ?? '00:00') as String,
      isCompleted: (fields[4] ?? false) as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.isCompleted);
  }
}

class TaskProvider extends ChangeNotifier {
  /// Hive box
  late Box<TaskModel> _taskBox;

  /// Temporary flow state (page → page)
  DateTime? selectedDate;
  String? selectedTime;

  /// In-memory list
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  /// INIT (call once in main)
  Future<void> init() async {
    _taskBox = Hive.box<TaskModel>('tasks');
    _tasks = _taskBox.values.toList();
    notifyListeners();
  }

  /// PAGE 1 – Calendar
  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  /// PAGE 2 – Clock
  void setTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  /// PAGE 3 – Create task
  void addTask({
    required String title,
    required String description,
    DateTime? date,
    String? time,
  }) {
    final task = TaskModel(
      title: title,
      description: description,
      date: date ?? DateTime.now(),
      time: time ?? "--:--",
    );

    _taskBox.add(task);
    _tasks.add(task);

    // reset temp state
    selectedDate = null;
    selectedTime = null;

    notifyListeners();
  }

  void deleteTask(int index) {
    _taskBox.deleteAt(index);
    _tasks.removeAt(index);
    notifyListeners();
  }

  void completeTask(int index) {
    final task = _tasks[index];
    task.isCompleted = true;
    _taskBox.putAt(index, task);
    _tasks[index] = task;
    notifyListeners();
  }

  void clearAll() {
    _taskBox.clear();
    _tasks.clear();
    notifyListeners();
  }
}