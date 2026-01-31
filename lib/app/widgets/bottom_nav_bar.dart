import 'package:flutter/material.dart';
import 'package:thinknotestudioapp/app/screens/home/home_screen.dart';
import 'package:thinknotestudioapp/app/screens/list/list_screen.dart';
import 'package:thinknotestudioapp/app/screens/notes/notes_screen.dart';
import 'package:floaty_navy_bar/floaty_navy_bar.dart';

class RollingNavBar extends StatefulWidget {
  @override
  _RollingNavBarState createState() => _RollingNavBarState();
}

class _RollingNavBarState extends State<RollingNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeScreen(), NotesScreen()];

  final List<IconData> icons = [
    Icons.table_rows_rounded,
    Icons.notes,
  ];
  final List<String> labels = ['Görevler', 'Notlar'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[140],
      body: Stack(
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
          FloatyNavyBar(
            opacityAnimation: true,
            backgroundColor: Colors.black.withOpacity(0.6),
            barHeight: 70.0,
            iconColor: Colors.white,
            textStyle: const TextStyle(color: Colors.white, fontSize: 14.0),
            iconSize: 28.0,
            indicatorColor: Colors.white,
            indicatorHeight: 3,
            indicatorWidth: 14.0,
            items: [
              NavyBarItem(icon: icons[0], title: labels[0]),
              NavyBarItem(icon: icons[1], title: labels[1]),
            ],
            onChanged: (index) {
              setState(() => _selectedIndex = index);
            },
          ),
        ],
      ),
    );
  }
}
