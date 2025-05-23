import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:thinknotestudioapp/app/screens/calendar/calendar_clock_screen.dart';
import 'package:thinknotestudioapp/app/widgets/slider_button.dart';
class CalendarClockScreen extends StatefulWidget {
  const CalendarClockScreen({super.key});

  @override
  State<CalendarClockScreen> createState() => _CalendarClockScreenState();
}

class _CalendarClockScreenState extends State<CalendarClockScreen> {
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
                  height: 77,
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

              const SizedBox(height: 30),

              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Choose\nthe time",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              const SizedBox(height: 20),

             
            ],
          ),
        ),
      ),
    );
  }
}
