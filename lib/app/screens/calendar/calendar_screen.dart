import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:thinknotestudioapp/app/screens/calendar/calendar_clock_screen.dart';
import 'package:thinknotestudioapp/app/widgets/slider_button.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('tr_TR', null);
    _selectedDay = _focusedDay;
  }

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
                      // Geri butonu
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
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
                      // Profil fotoğrafı
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
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Choose\nthe date",
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TableCalendar(
                  locale: 'tr_TR',
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2900, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.deepOrange,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(color: Colors.white),
                    todayTextStyle: TextStyle(color: Colors.white),
                    selectedTextStyle: TextStyle(color: Colors.white),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.white),
                    weekendStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const Spacer(),

              RotatingSliderButton(
                onSlideCompleted: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarClockScreen(),
                    ),
                  );
                }, text: 'Swipe to add time',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
