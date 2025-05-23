import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:thinknotestudioapp/app/splash/splash_screen.dart';
// eecf7684-405e-4084-a039-079a0e021c22
void main() async {
  runApp(MyApp());

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("eecf7684-405e-4084-a039-079a0e021c22");
  OneSignal.Notifications.requestPermission(true);
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
      home: const MyHomePage(title: 'ThinkNote Studio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SplashScreen(),
      
    );


  }
}
