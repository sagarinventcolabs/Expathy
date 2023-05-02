import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';

class GradientBackgroundWidget extends StatefulWidget {
  final Widget child;
  const GradientBackgroundWidget({Key? key, required this.child})
      : super(key: key);

  @override
  State<GradientBackgroundWidget> createState() =>
      _GradientBackgroundWidgetState();
}

class _GradientBackgroundWidgetState extends State<GradientBackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 1],
            colors: [
              AppColors.green,
              AppColors.gradientBelowColor,
            ],
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
