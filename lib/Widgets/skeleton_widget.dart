import 'package:expathy/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class SkeletonWidget extends StatelessWidget {
  final double? radius;
  final double? height;
  final double? width;
  final double? padding;
  final double? topMargin;
  final double? bottomMargin;
  final double? leftMargin;
  final double? rightMargin;
  final Widget? child;

  const SkeletonWidget(
      {Key? key,
      this.radius,
      this.height,
      this.width,
      this.padding,
      this.topMargin,
      this.bottomMargin,
      this.leftMargin,
      this.rightMargin,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
          left: leftMargin ?? 0.0,
          right: rightMargin ?? 0.0,
          top: topMargin ?? 0.0,
          bottom: bottomMargin ?? 0.0),
      padding: EdgeInsets.all(padding ?? 0.0),
      decoration: BoxDecoration(
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(radius ?? 0.0)),
      child: child,
    );
  }
}
