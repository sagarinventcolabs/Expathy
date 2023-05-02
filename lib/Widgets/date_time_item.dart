import 'package:flutter/material.dart';

import '../Common Widgets/text_widget.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_fonts.dart';
import '../Utils/helper_methods.dart';

class DateTimeItem extends StatefulWidget {
  final String? value;
  final String? heading;
  final CrossAxisAlignment crossAxisAlignment;
  const DateTimeItem(
      {Key? key, this.value, this.heading, required this.crossAxisAlignment})
      : super(key: key);

  @override
  State<DateTimeItem> createState() => _DateTimeItemState();
}

class _DateTimeItemState extends State<DateTimeItem> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: widget.crossAxisAlignment, children: [
      TextWidget(
        text: widget.value ?? '',
        fontSize: 16,
        fontFamily: AppFonts.poppins,
        fontWeight: FontWeight.w500,
      ),
      heightGap(5),
      TextWidget(
        text: widget.heading ?? '',
        fontSize: 16,
        fontFamily: AppFonts.poppins,
        color: AppColors.greyText,
        fontWeight: FontWeight.w400,
      ),
    ]);
  }
}
