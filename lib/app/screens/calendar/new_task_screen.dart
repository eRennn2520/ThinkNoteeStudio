import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:thinknotestudioapp/app/widgets/bottom_nav_bar.dart';
import 'package:thinknotestudioapp/app/widgets/slider_button.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _reminderEnabled = false; // State for the switch

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    var screenWidth = screenSize.size.width;
    var screenHeight = screenSize.size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/calendar.png"),
              fit: BoxFit.cover,
            ),
          ),
          width: screenWidth,
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.09),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Container(
                  height: screenHeight * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Icon(
                                  EvaIcons.arrowIosBack,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Icon(
                                EvaIcons.calendar,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 28,
                          backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1633113214698-485cdb2f56fd?q=80&w=1974&auto=format&fit=crop",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "Add new\ntask",
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Task Title TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Task Title",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Task Description TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Task Description",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3, // Allow multiple lines for description
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Enable Reminder Switch
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enable reminder",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Switch(
                      value: _reminderEnabled,
                      onChanged: (value) =>
                          setState(() => _reminderEnabled = value),
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              Spacer(),
              RotatingSliderButton(
                onSlideCompleted: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => RollingNavBar()),
                    (Route<dynamic> route) => false,
                  );
                },
                text: 'Swipe to proceed',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
