import 'package:flutter/material.dart';

import '../Common Widgets/text_widget.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_fonts.dart';

class UnderLineText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  const UnderLineText(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.textColor = AppColors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      text: text,
      fontSize: fontSize,
      fontFamily: AppFonts.poppins,
      fontWeight: FontWeight.w500,
      color: Colors.transparent,
      shadows: [Shadow(offset: const Offset(0, -10), color: textColor)],
      decoration: TextDecoration.underline,
      decorationColor: AppColors.yellow,
      decorationThickness: 3,
    );
  }
}
