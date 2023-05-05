import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class WalkthroughCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5291372, size.height * 0.08239964);
    path_0.cubicTo(
        size.width * 0.1692307,
        size.height * 0.2316332,
        size.width * 0.02641814,
        size.height * 0.1012976,
        0,
        size.height * 0.01747566);
    path_0.lineTo(0, size.height * 0.7828467);
    path_0.lineTo(size.width, size.height * 0.7828467);
    path_0.lineTo(size.width, size.height * 0.08239964);
    path_0.cubicTo(
        size.width * 0.9930070,
        size.height * 0.02021898,
        size.width * 0.8890442,
        size.height * -0.06683412,
        size.width * 0.5291372,
        size.height * 0.08239964);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xff037D6B).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5291372, size.height * 0.1716235);
    path_1.cubicTo(
        size.width * 0.1692307,
        size.height * 0.3205091,
        size.width * 0.02641814,
        size.height * 0.1904781,
        0,
        size.height * 0.1068509);
    path_1.lineTo(0, size.height);
    path_1.lineTo(size.width, size.height);
    path_1.lineTo(size.width, size.height * 0.1716235);
    path_1.cubicTo(
        size.width * 0.9930070,
        size.height * 0.1095878,
        size.width * 0.8890442,
        size.height * 0.02273777,
        size.width * 0.5291372,
        size.height * 0.1716235);
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
