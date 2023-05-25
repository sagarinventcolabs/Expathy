import 'package:flutter/material.dart';

import '../Common Widgets/text_widget.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewAllRowWidget extends StatelessWidget {
  final String? text;
  final Color textColor;
  final Color viewAllColor;
  final Function()? onViewAllPressed;
  const ViewAllRowWidget(
      {Key? key,
      this.text,
      this.textColor = AppColors.white,
      this.viewAllColor = AppColors.white,
      this.onViewAllPressed})
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
        InkWell(
          onTap: onViewAllPressed,
          child: TextWidget(
            text: AppLocalizations.of(context)!.viewAll,
            fontSize: 14,
            color: viewAllColor,
            decoration: TextDecoration.underline,
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
