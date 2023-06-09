import 'package:flutter/material.dart';

class NavigationServices {
  static Future<void> push(
      {required BuildContext context, required Widget screen}) async {
    Navigator.of(context).push(
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return screen;
          },
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation =
                CurvedAnimation(curve: Curves.easeIn, parent: animation);

            return SlideTransition(
              position: Tween(
                      begin: const Offset(-1.0, 0.0),
                      end: const Offset(0.0, 0.0))
                  .animate(animation),
              child: child,
            );
          }),
    );
  }

  static Future<void> pushReplacement(
      {required BuildContext context, required Widget screen}) async {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return screen;
          },
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation =
                CurvedAnimation(curve: Curves.easeIn, parent: animation);
            return SlideTransition(
              position: Tween(
                      begin: const Offset(-1.0, 0.0),
                      end: const Offset(0.0, 0.0))
                  .animate(animation),
              child: child,
            );
          }),
    );
  }

  static Future<void> pushAndRemoveUntil(
      {required BuildContext context, required Widget screen}) async {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return screen;
          },
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation =
                CurvedAnimation(curve: Curves.easeIn, parent: animation);
            return SlideTransition(
              position: Tween(
                      begin: const Offset(-1.0, 0.0),
                      end: const Offset(0.0, 0.0))
                  .animate(animation),
              child: child,
            );
          }),
      (route) => false,
    );
  }
}
