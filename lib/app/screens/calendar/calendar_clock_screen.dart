import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:thinknotestudioapp/app/screens/calendar/new_task_screen.dart';
import 'package:thinknotestudioapp/app/widgets/slider_button.dart';
import 'package:thinknotestudioapp/provider.dart';

class CalendarClockScreen extends StatefulWidget {
  const CalendarClockScreen({super.key});

  @override
  State<CalendarClockScreen> createState() => _CalendarClockScreenState();
}

class _CalendarClockScreenState extends State<CalendarClockScreen> {
  DateTime _focusedDay = DateTime.now();
  int _selectedHour = 6;
  int _selectedMinute = 28;
  int _selectedSecond = 55;
  String _selectedPeriod = 'ÖS';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('tr_TR', null);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final horizontalPadding = screenWidth * 0.08;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/calendar.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.09),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Container(
                  height: screenHeight * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.09),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: screenWidth * 0.08,
                            child: Icon(
                              EvaIcons.arrowIosBack,
                              color: Colors.black,
                              size: screenWidth * 0.07,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.03),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: screenWidth * 0.075,
                          backgroundImage: const NetworkImage(
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
                padding: EdgeInsets.only(left: horizontalPadding),
                child: Text(
                  "Görevin\nSaati",
                  style: TextStyle(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.08),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimePicker(
                      itemCount: 12,
                      selectedIndex: _selectedHour,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedHour = index;
                        });
                      },
                    ),
                    _buildTimeSeparator(),
                    _buildTimePicker(
                      itemCount: 60,
                      selectedIndex: _selectedMinute,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedMinute = index;
                        });
                      },
                    ),
                    _buildTimeSeparator(),
                    _buildTimePicker(
                      itemCount: 60,
                      selectedIndex: _selectedSecond,
                      itemWidth: 40,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedSecond = index;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildPeriodPicker(),
                  ],
                ),
              ),

              const Spacer(),

              RotatingSliderButton(
                onSlideCompleted: () {
                  final taskProvider = context.read<TaskProvider>();

                  final time =
                      "${_selectedHour.toString().padLeft(2, '0')}:"
                      "${_selectedMinute.toString().padLeft(2, '0')} "
                      "$_selectedPeriod";

                  // Saat Provider'a yazılıyor
                  taskProvider.setTime(time);

                  // NET geçiş (stack sorunu yok)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewTaskScreen(),
                    ),
                  );
                },
                text: 'Devam',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required int itemCount,
    required int selectedIndex,
    required ValueChanged<int> onSelectedItemChanged,
    double itemWidth = 60,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return SizedBox(
      width: itemWidth,
      height: screenHeight * 0.3,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40,
        perspective: 0.005,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List<Widget>.generate(itemCount, (index) {
            return Center(
              child: Text(
                index.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 24,
                  color: selectedIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTimeSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(" : ", style: TextStyle(fontSize: 24, color: Colors.white)),
    );
  }

  Widget _buildPeriodPicker() {
    return SizedBox(
      width: 60,
      height: 100,
      child: ListWheelScrollView.useDelegate(
        controller: FixedExtentScrollController(
          initialItem: _selectedPeriod == 'ÖÖ' ? 0 : 1,
        ),
        itemExtent: 40,
        perspective: 0.005,
        diameterRatio: 1.5,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedPeriod = index == 0 ? 'ÖÖ' : 'ÖS';
          });
        },
        childDelegate: ListWheelChildListDelegate(
          children: ['ÖÖ', 'ÖS'].map((period) {
            return Center(
              child: Text(
                period,
                style: TextStyle(
                  fontSize: 24,
                  color: _selectedPeriod == period
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
