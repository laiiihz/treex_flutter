import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class PaintAccountTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.blue
      ..isAntiAlias = true
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    Rect rect = Rect.fromPoints(Offset(0, 100), Offset(size.width, 150));
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, 125), _paint);
    canvas.drawOval(rect, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
