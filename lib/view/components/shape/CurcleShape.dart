import 'package:changa_lab/core/utils/my_color.dart';
import 'package:flutter/material.dart';

class MyCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = MyColor.bg1.withOpacity(0.09)
      ..strokeWidth = 15;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, 100, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
