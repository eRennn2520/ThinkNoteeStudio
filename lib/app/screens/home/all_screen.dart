import 'dart:math';
import 'package:flutter/material.dart';
import 'package:thinknotestudioapp/app/screens/home/widgets/all_widgets.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  final Random random = Random();

  final List<List<Color>> gradients = [
    [Color(0xFF9575CD), Color(0xFFFFB74D)],
    [Color(0xFF6A1B9A), Color(0xFFF48FB1)],
    [Color(0xFFC2185B), Color(0xFFF8BBD0)],
    [Color(0xFF4A90E2), Color(0xFFFF6F61)],
    [Color(0xFF2E7D32), Color(0xFFFFF176)],
    [Color(0xFF283593), Color(0xFFFF8A65)],
    [Color(0xFF00897B), Color(0xFFFFAB91)],
  ];

  late List<Map<String, dynamic>> meetings;

  @override
  void initState() {
    super.initState();

    final shuffledGradients = List<List<Color>>.from(gradients);
    shuffledGradients.shuffle(random);

    meetings = [
      {
        'date': '23 May 2025',
        'time': '07:59 PM',
        'title': 'Meeting with manager at park',
        'description':
            'This meeting shouldn\'t be missed at any cost, it\'s really an important meeting with manager.',
      },
      {
        'date': '24 May 2025',
        'time': '10:00 AM',
        'title': 'Team Sync Up',
        'description': 'Weekly team meeting to discuss progress.',
      },
      {
        'date': '25 May 2025',
        'time': '02:30 PM',
        'title': 'Client Presentation',
        'description': 'Prepare and deliver client proposal.',
      },
      // Daha fazla eklenebilir...
    ];

    // meetings listesindeki her elemana döngüsel olarak gradient ata
    for (int i = 0; i < meetings.length; i++) {
      meetings[i]['gradient'] = LinearGradient(
        colors: shuffledGradients[i % shuffledGradients.length],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: meetings.length,
                itemBuilder: (context, index) {
                  final meeting = meetings[index];
                  return MeetingWidget(
                    date: meeting['date'],
                    time: meeting['time'],
                    title: meeting['title'],
                    description: meeting['description'],
                    gradient: meeting['gradient'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
