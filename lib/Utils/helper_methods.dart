import 'dart:io';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/main.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../Common Widgets/text_widget.dart';
import '../Screens/Auth Screens/prehome_screen.dart';
import 'app_colors.dart';

const emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

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

Future<void> checkDeviceOs() async {
  if (Platform.isAndroid) {
    sharedPrefs?.setString(AppStrings.deviceOs, 'Android');
  } else if (Platform.isIOS) {
    sharedPrefs?.setString(AppStrings.deviceOs, 'Ios');
  }
}

void showSnackBar({
  BuildContext? context,
  String? message,
  bool isSuccess = true,
}) {
  final snackBar = SnackBar(
    elevation: 6,
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    content: Row(
      children: [
        isSuccess
            ? const Icon(Icons.check, color: AppColors.white)
            : const Icon(Icons.error_outline_rounded, color: AppColors.white),
        widthGap(10),
        Flexible(
            child: TextWidget(
          text: message ?? "",
          color: AppColors.white,
          overflow: TextOverflow.fade,
        )),
      ],
    ),
    backgroundColor: isSuccess ? AppColors.greenLight : AppColors.red,
  );
  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}

Widget shimmerEffect({required Widget widget}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade500,
    highlightColor: Colors.grey.shade400,
    child: widget,
  );
}

Future<void> showWarningDialog(
    {BuildContext? context,
    double? radius,
    String? title,
    bool barrierDismissible = true,
    String? content,
    List<Widget>? widget}) async {
  return showDialog<void>(
    context: context!,
    barrierDismissible: barrierDismissible, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 0)),
        content: TextWidget(
          text: content ?? '',
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontFamily: AppFonts.poppins,
        ),
        title: TextWidget(
          text: title ?? '',
          color: AppColors.black,
          fontSize: 22,
          fontWeight: FontWeight.w400,
          fontFamily: AppFonts.poppins,
        ),
        actions: widget,
      );
    },
  );
}

Future<void> logOut({BuildContext? context}) async {
  sharedPrefs?.remove(AppStrings.isFreePlan);
  sharedPrefs?.remove(AppStrings.token);
  sharedPrefs?.remove(AppStrings.userName);
  sharedPrefs?.remove(AppStrings.email);
  //sharedPrefs?.remove(AppStrings.rememberMeEmail);
  //sharedPrefs?.remove(AppStrings.rememberMePassword);
  sharedPrefs?.remove(AppStrings.deviceOs);
  sharedPrefs?.remove(AppStrings.isLogin);
  sharedPrefs?.remove(AppStrings.isQuestionSubmit);
  sharedPrefs?.remove(AppStrings.isHaveOneTherapists);
  sharedPrefs?.setBool(AppStrings.isFirstTimeOnApp, false);
  Navigator.of(context!).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const PreHomeScreen(),
    ),
    (route) => false,
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
