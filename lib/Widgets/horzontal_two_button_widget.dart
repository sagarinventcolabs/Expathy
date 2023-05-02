import 'package:flutter/material.dart';

import '../Common Widgets/elevated_button_widget.dart';
import '../Utils/app_colors.dart';
import '../Utils/helper_methods.dart';

class HorizontalTwoButtonWidget extends StatefulWidget {
  final text1;
  final text2;
  final Function()? text1Tap;
  final Function()? text2Tap;
  const HorizontalTwoButtonWidget(
      {Key? key, this.text1, this.text2, this.text1Tap, this.text2Tap})
      : super(key: key);

  @override
  State<HorizontalTwoButtonWidget> createState() =>
      _HorizontalTwoButtonWidgetState();
}

class _HorizontalTwoButtonWidgetState extends State<HorizontalTwoButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: ElevatedButtonWidget(
            onPressed: widget.text1Tap,
            elevation: 0,
            showBorder: true,
            textColor: AppColors.green,
            forGroundColor: AppColors.green,
            text: widget.text1 ?? '',
            primary: AppColors.white),
      ),
      widthGap(20),
      Expanded(
        child: ElevatedButtonWidget(
          onPressed: widget.text2Tap,
          text: widget.text2 ?? '',
        ),
      ),
    ]);
  }
}
