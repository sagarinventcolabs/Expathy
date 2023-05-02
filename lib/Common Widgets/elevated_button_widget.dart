import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final double? elevation;
  final Color? shadowColor;
  final double? borderRadius;
  final double? fontSize;
  final String fontFamily;
  final Color? textColor;
  final double offset;
  final bool showArrow;
  final Color? primary;
  final Color? forGroundColor;
  final Color borderColor;
  final double height;
  final FontWeight fontWeight;
  final bool showBorder;
  const ElevatedButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.elevation,
    this.shadowColor,
    this.borderRadius,
    this.fontSize = 17,
    this.fontFamily = AppFonts.poppins,
    this.textColor = AppColors.white,
    this.offset = 5.5,
    this.showArrow = false,
    this.height = 55,
    this.fontWeight = FontWeight.w500,
    this.primary = AppColors.green,
    this.showBorder = false,
    this.borderColor = AppColors.green,
    this.forGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: showBorder ? Border.all(width: 1, color: borderColor) : null),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: primary,
            shadowColor: shadowColor,
            foregroundColor: forGroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            )),
        child: FittedBox(
          child: TextWidget(
            text: text ?? "",
            textAlign: TextAlign.center,
            color: textColor,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
