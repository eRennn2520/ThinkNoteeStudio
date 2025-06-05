import 'dart:math';
import 'package:flutter/material.dart';
import 'package:thinknotestudioapp/app/screens/home/widgets/all_widgets.dart';
class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
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

    // Örnek meetings listesi, kullanıcı istediği kadar toplantı ekleyebilir
    meetings = [
      {
        'date': '23 May 2025',
        'time': '07:59 PM',
        'title': 'Project Kickoff',
        'description': 'Initial meeting to start the new project with all stakeholders.',
      },
      {
        'date': '24 May 2025',
        'time': '10:00 AM',
        'title': 'Design Review',
        'description': 'Review design drafts and finalize the UX/UI.',
      },
      {
        'date': '25 May 2025',
        'time': '02:30 PM',
        'title': 'Marketing Strategy',
        'description': 'Discuss marketing plans for the upcoming quarter.',
      },
      {
        'date': '26 May 2025',
        'time': '11:00 AM',
        'title': 'Budget Meeting',
        'description': 'Finalize budget allocations for all departments.',
      },
      {
        'date': '27 May 2025',
        'time': '03:15 PM',
        'title': 'Product Demo',
        'description': 'Demonstrate the latest product features to clients.',
      },
      {
        'date': '28 May 2025',
        'time': '09:30 AM',
        'title': 'HR Update',
        'description': 'Discuss new HR policies and employee benefits.',
      },
      {
        'date': '29 May 2025',
        'time': '01:00 PM',
        'title': 'Tech Workshop',
        'description': 'Workshop on new technology adoption for the team.',
      },
      {
        'date': '30 May 2025',
        'time': '04:00 PM',
        'title': 'Sales Review',
        'description': 'Monthly review of sales performance and targets.',
      },
      {
        'date': '31 May 2025',
        'time': '11:30 AM',
        'title': 'Customer Feedback',
        'description': 'Analyze customer feedback and plan improvements.',
      },
      {
        'date': '01 Jun 2025',
        'time': '08:45 AM',
        'title': 'Security Briefing',
        'description': 'Overview of security protocols and updates.',
      },
      {
        'date': '02 Jun 2025',
        'time': '03:00 PM',
        'title': 'Strategy Planning',
        'description': 'Long-term strategy planning session.',
      },
      {
        'date': '03 Jun 2025',
        'time': '05:00 PM',
        'title': 'Team Building',
        'description': 'Activities to enhance teamwork and collaboration.',
      },
      // İstersen daha fazla ekleyebilirsin...
    ];

    // Gradientleri karıştır
    final shuffledGradients = List<List<Color>>.from(gradients);
    shuffledGradients.shuffle(random);

    // Meetings listesindeki her elemana döngüsel şekilde gradient ata
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
     
      body: ListView.builder(
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
    );
  }
}