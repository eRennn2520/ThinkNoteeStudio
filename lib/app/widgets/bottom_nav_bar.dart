import 'package:flutter/material.dart';
import 'package:thinknotestudioapp/app/progress/progress_screen.dart';
import 'package:thinknotestudioapp/app/screens/home/home_screen.dart';
import 'package:thinknotestudioapp/app/screens/list/list_screen.dart';
import 'package:thinknotestudioapp/app/screens/notes/notes_screen.dart';

class RollingNavBar extends StatefulWidget {
  @override
  _RollingNavBarState createState() => _RollingNavBarState();
}

class _RollingNavBarState extends State<RollingNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    NotesScreen(),
    ListScreen(),

    ProgressScreen(),
  ];

  final List<IconData> icons = [
    Icons.table_rows_rounded,
    Icons.notes,
    Icons.list_alt,
    Icons.calendar_today,
  ];

  final List<String> labels = ['Overview', 'Notes', 'Lists', 'Progress'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          /// Aktif sayfa
          AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            transitionBuilder: (child, anim) => SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.1, 0),
                end: Offset.zero,
              ).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: _pages[_selectedIndex],
          ),
      
          /// Alt bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(26),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    colors: [Color(0xFFEDEEFF), Color(0xFFFFF1E6)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedAlign(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      alignment: [
                        Alignment(-1.0, 0),
                        Alignment(-0.33, 0),
                        Alignment(0.33, 0),
                        Alignment(1.0, 0),
                      ][_selectedIndex],
                      child: Container(
                        width: 87,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFCBB9FF),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(icons.length, (index) {
                        final isSelected = index == _selectedIndex;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedIndex = index),
                          child: SizedBox(
                            width: 64,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Icon(
                                    icons[index],
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                isSelected
                                    ? SizedBox.shrink()
                                    : Text(
                                        labels[index],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
