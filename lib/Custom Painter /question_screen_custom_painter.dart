import 'package:flutter/material.dart';

class QuestionScreenCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5291372, size.height * 0.3222480);
    path_0.cubicTo(
        size.width * 0.2755814,
        size.height * 0.4377305,
        size.width * 0.02641814,
        size.height * 0.3626074,
        0,
        size.height * 0.1835941);
    path_0.lineTo(0, size.height * 1.001742);
    path_0.lineTo(size.width, size.height * 1.001742);
    path_0.lineTo(size.width, size.height * 0.3222480);
    path_0.cubicTo(
        size.width * 0.9930070,
        size.height * 0.1894527,
        size.width * 0.6453488,
        size.height * 0.2693195,
        size.width * 0.5291372,
        size.height * 0.3222480);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xff037D6B).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5291372, size.height * 0.3673816);
    path_1.cubicTo(
        size.width * 0.2755814,
        size.height * 0.4828633,
        size.width * 0.02641814,
        size.height * 0.4077422,
        0,
        size.height * 0.2287277);
    path_1.lineTo(0, size.height);
    path_1.lineTo(size.width, size.height);
    path_1.lineTo(size.width, size.height * 0.3673816);
    path_1.cubicTo(
        size.width * 0.9930070,
        size.height * 0.2345863,
        size.width * 0.6453488,
        size.height * 0.3144531,
        size.width * 0.5291372,
        size.height * 0.3673816);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = const Color(0xff012B28).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
