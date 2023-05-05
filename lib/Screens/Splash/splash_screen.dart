import 'dart:async';
import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Screens/Walkthrough%20Screens/tutorial_screen.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/svg_picture.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TutorialScreen(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      statusBarIconBrightness: Brightness.dark,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            /*image: DecorationImage(
              image: AssetImage(AppImages.splashBg), fit: BoxFit.cover),*/
            color: AppColors.green),
        child: Center(
          child: SizedBox(
            width: deviceWidth(context) * 0.60,
            height: deviceHeight(context) * 0.30,
            child: const SvgPic(
              image: AppImages.logoMain,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
