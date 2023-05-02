import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:flutter/material.dart';

class ToolBarWidget extends StatelessWidget {
  final Color? iconColor;
  final Color? titleColor;
  final String? title;
  final Function() onTap;
  final bool showArrowIcon;
  const ToolBarWidget(
      {Key? key,
      this.iconColor = AppColors.white,
      required this.onTap,
      this.titleColor = AppColors.white,
      this.title,  this.showArrowIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(showArrowIcon)
        InkWell(
          onTap: onTap,
          child: Icon(
            Icons.arrow_back_ios,
            color: iconColor,
            size: 28,
          ),
        ),
        widthGap(5),
        TextWidget(
          text: title ?? '',
          color: titleColor,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ],
    );
  }
}
