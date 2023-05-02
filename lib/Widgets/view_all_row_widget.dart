import 'package:flutter/material.dart';

import '../Common Widgets/text_widget.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_fonts.dart';

class ViewAllRowWidget extends StatelessWidget {
  final String? text;
  final Color textColor;
  final Color viewAllColor;
  const ViewAllRowWidget(
      {Key? key,
      this.text,
      this.textColor = AppColors.white,
      this.viewAllColor = AppColors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextWidget(
            text: text ?? '',
            fontSize: 18,
            color: textColor,
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextWidget(
          text: 'View all',
          fontSize: 14,
          color: viewAllColor,
          decoration: TextDecoration.underline,
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
