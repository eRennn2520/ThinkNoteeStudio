import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:thinknotestudioapp/app/splash/splash_screen.dart';
import 'package:thinknotestudioapp/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');

  // Provider init
  final taskProvider = TaskProvider();
  await taskProvider.init();

  runApp(
    ChangeNotifierProvider<TaskProvider>.value(
      value: taskProvider,
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
