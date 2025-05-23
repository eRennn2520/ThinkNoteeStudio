import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thinknotestudioapp/app/screens/home/home_screen.dart';
import 'package:thinknotestudioapp/app/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    var screenWidth = screenSize.size.width;
    var screenHeight = screenSize.size.height;
   Timer(
      const Duration(seconds: 4),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>  RollingNavBar())),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/logo.jpg", width: screenWidth * 5)],
        ),
      ),
    );
  }
}
