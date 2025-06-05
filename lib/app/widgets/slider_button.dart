import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shimmer/shimmer.dart';

class RotatingSliderButton extends StatefulWidget {
  final VoidCallback onSlideCompleted;
  String text;

   RotatingSliderButton({super.key, required this.onSlideCompleted,required this.text});

  @override
  State<RotatingSliderButton> createState() => _RotatingSliderButtonState();
}

class _RotatingSliderButtonState extends State<RotatingSliderButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  double _maxDragDistance = 300.0;
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final double rotationAngle =
        (_dragPosition / _maxDragDistance) * 2 * math.pi;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: _maxDragDistance + 60,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A4A4A), Color(0xFF1C1C1C)],
                ),
              ),
              alignment: Alignment.center,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                period: const Duration(seconds: 2),
                child:  Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Positioned(
            left: _dragPosition + 15,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition += details.delta.dx;
                  _dragPosition = _dragPosition.clamp(0.0, _maxDragDistance);
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragPosition >= _maxDragDistance * 0.9) {
                  setState(() {
                    _dragPosition = _maxDragDistance;
                    _isCompleted = true;
                  });
                  widget.onSlideCompleted();

                  // 1 saniye bekle ve geri sıfırla
                  Future.delayed(const Duration(seconds: 1), () {
                    if (mounted) {
                      setState(() {
                        _dragPosition = 0.0;
                        _isCompleted = false;
                      });
                    }
                  });
                } else {
                  setState(() {
                    _dragPosition = 0.0;
                    _isCompleted = false;
                  });
                }
              },

              child: Transform.rotate(
                angle: rotationAngle,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFCEB7FF),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
