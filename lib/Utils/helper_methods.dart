import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expathy/Screens/Auth%20Screens/login_screen.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/Widgets/svg_picture.dart';
import 'package:expathy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../Common Widgets/text_widget.dart';
import 'app_colors.dart';
import 'app_images.dart';

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

///Time

String? convert12HourTo24Hour({required String time}) {
  ///convert 01.29Am to 13.29
  if (time == '') {
    return null;
  }
  DateTime date2 = DateFormat("hh:mma").parse(time);
  print(DateFormat("HH:mm").format(date2));
  return DateFormat("HH:mm").format(date2);
}

String? convert24HourTo12Hour({required String time, bool showAmPm = false}) {
  ///convert 13.29 to 01.29 Am
  print(time);
  if (time == '') {
    return null;
  }
  DateTime date2 = DateFormat("HH:mm").parse(time);
  if (showAmPm) {
    return DateFormat("h:mm a").format(date2);
  } else {
    return DateFormat("h:mm").format(date2);
  }
}

dateTimeFormat(val) {
  if (val == '') {
    return;
  }
  var getDate = DateTime.parse("$val");
  var formattedDate =
      DateFormat("dd-MM-yyyy hh:mm a").format(getDate.toLocal());
  return formattedDate.toString();
}

convertTimeStampToTime({String? timeStamp}) {
  if (timeStamp == null || timeStamp == '') {
    return;
  }
  DateTime data = DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp));
  return DateFormat('HH:mm a').format(data);
}

convertTimeStampToLocalDate({String? timeStamp}) {
  if (timeStamp == null || timeStamp == '') {
    return;
  }
  DateTime data = DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp));
  return DateFormat('dd-MMM-yyy').format(data);
}

getDateFormatted({String? data, bool showMonthTextMiddle = false}) {
  if (data == null || data == '') {
    return '';
  }
  var parsedDate = DateTime.parse(data);
  var outputFormat;
  if (showMonthTextMiddle) {
    var date = DateFormat("d MMMM y");
    outputFormat = date;
  } else {
    var date = DateFormat("yyyy-MM-dd");
    outputFormat = date;
  }

  return outputFormat.format(parsedDate);
}

getTimeFormatted(String? data) {
  if (data == null || data == '') {
    return '';
  }
  final dateTime = DateTime.parse(data);
  final format = DateFormat('HH:mm a');
  return format.format(dateTime);
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

Widget noData({String? title, required BuildContext context}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Lottie.asset(AppImages.emptyJson, width: 300, height: 300),
        Container(
            width: deviceWidth(context) * 50,
            height: deviceHeight(context) * 0.30,
            child: const SvgPic(image: AppImages.noData)),
        TextWidget(
          text: title ?? '',
          color: AppColors.green,
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ],
    ),
  );
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
    /* baseColor: Colors.grey.shade500,
    highlightColor: Colors.grey.shade400,*/
    baseColor: AppColors.shimmerBaseColor,
    highlightColor: Colors.white,
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

Future<void> closeKeyBoard({required BuildContext context}) async {
  FocusScope.of(context).unfocus();
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
      builder: (context) => const LoginScreen(),
    ),
    (route) => false,
  );
}

Widget circleImage({String? url}) {
  return CachedNetworkImage(
    width: 75,
    height: 75,
    imageUrl: url ?? '',
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) => Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Center(child: CupertinoActivityIndicator()),
    ),
    errorWidget: (context, url, error) => Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Center(
          child: Icon(
        Icons.person,
        color: AppColors.green,
      )),
    ),
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
