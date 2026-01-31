import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:thinknotestudioapp/app/splash/splash_screen.dart';
import 'package:thinknotestudioapp/provider.dart';
import 'package:thinknotestudioapp/app/screens/notes/note_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive init
  await Hive.initFlutter();

  // TASKS
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');

  // NOTES
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notes_box');

  // Provider init
  final taskProvider = TaskProvider();
  await taskProvider.init();

  final noteProvider = NoteProvider();
  await noteProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskProvider>.value(value: taskProvider),
        ChangeNotifierProvider<NoteProvider>.value(value: noteProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThinkNote Studio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const SplashScreen(),
    );
  }
}
