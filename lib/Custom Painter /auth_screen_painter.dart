import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class AuthScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5291372, size.height * 0.9053354);
    path_0.cubicTo(
        size.width * 0.1692307,
        size.height * 0.7338889,
        size.width * 0.02641814,
        size.height * 0.8836247,
        0,
        size.height * 0.9799224);
    path_0.lineTo(0, size.height * 0.1006289);
    path_0.lineTo(size.width, size.height * 0.1006289);
    path_0.lineTo(size.width, size.height * 0.9053354);
    path_0.cubicTo(
        size.width * 0.9930070,
        size.height * 0.9767715,
        size.width * 0.8890442,
        size.height * 1.076782,
        size.width * 0.5291372,
        size.height * 0.9053354);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xffEBB42C).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5291372, size.height * 0.8028302);
    path_1.cubicTo(
        size.width * 0.1692307,
        size.height * 0.6317841,
        size.width * 0.02641814,
        size.height * 0.7811698,
        0,
        size.height * 0.8772453);
    path_1.lineTo(0, 0);
    path_1.lineTo(size.width, 0);
    path_1.lineTo(size.width, size.height * 0.8028302);
    path_1.cubicTo(
        size.width * 0.9930070,
        size.height * 0.8741006,
        size.width * 0.8890442,
        size.height * 0.9738784,
        size.width * 0.5291372,
        size.height * 0.8028302);
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
