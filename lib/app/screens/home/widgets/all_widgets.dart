import 'package:flutter/material.dart';

class MeetingWidget extends StatelessWidget {
  final String date;
  final String time;
  final String title;
  final String description;
  final LinearGradient gradient;

  const MeetingWidget({
    super.key,
    required this.date,
    required this.time,
    required this.title,
    required this.description,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          // İçerik sütunu
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 56), // Sağ üst avatar için boşluk bırak
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Sağ üst avatar
          Positioned(
            top: 0,
            right: 0,
            child:  CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child:Icon(Icons.arrow_outward_sharp)
            ),
          ),
        ],
      ),
    );
  }
}
