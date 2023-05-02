import 'package:flutter/material.dart';

import '../Common Widgets/text_widget.dart';
import 'app_colors.dart';

SizedBox heightGap(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox widthGap(double width) {
  return SizedBox(
    width: width,
  );
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Future<void> showWarningDialog(
    {BuildContext? context,
    double? radius,
    String? title,
    String? content,
    List<Widget>? widget}) async {
  return showDialog<void>(
    context: context!,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 0)),
        content: TextWidget(
          text: content ?? '',
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        title: TextWidget(
          text: title ?? '',
          color: AppColors.black,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
        actions: widget,
      );
    },
  );
}

Widget divider() {
  return Row(children: <Widget>[
    Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 0.0, right: 20.0),
          child: const Divider(
            color: Colors.black,
            height: 36,
          )),
    ),
    const Text("OR"),
    Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 0.0),
          child: const Divider(
            color: Colors.black,
            height: 36,
          )),
    ),
  ]);
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
