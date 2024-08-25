import 'package:changa_lab/core/utils/my_color.dart';
import 'package:flutter/material.dart';

class MySqarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = MyColor.bg1.withOpacity(0.09)
      ..strokeWidth = 15;
    Offset a = Offset(size.width * 1 / 4, size.height * 1 / 4);
    Offset b = Offset(size.width * 3 / 4, size.height * 3 / 4);
    Rect rRect = Rect.fromPoints(a, b);
    canvas.drawRect(rRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
