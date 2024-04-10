import 'package:flutter/material.dart';

class BrushStrokeXPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    // Draw first line X
    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);

    // Draw second line X
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
