import 'dart:async';
import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Screens/Auth%20Screens/prehome_screen.dart';
import 'package:expathy/Screens/Walkthrough%20Screens/tutorial_screen.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/svg_picture.dart';
import 'package:flutter/material.dart';

import '../../Utils/app_strings.dart';
import '../../main.dart';
import '../Bottom Bar Screen/bottom_bar_screen.dart';
import '../Question Answer Screen/first_question_screen.dart';
import '../Therapists Screen/therapists_list_screen.dart';

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
        if (sharedPrefs?.getBool(AppStrings.isLogin) ?? false) {
          if (sharedPrefs?.getBool(AppStrings.isQuestionSubmit) != true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const FirstQuestionScreen(showLogoutDialog: true),
              ),
            );
          } else if (sharedPrefs?.getBool(AppStrings.isHaveOneTherapists) !=
              true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TherapistsListScreen(
                    showChangeLanguageDialog: true, showBackButton: false),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomBarScreen(),
              ),
            );
          }
        } else {
          if (sharedPrefs?.getBool(AppStrings.isFirstTimeOnApp) ?? true) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TutorialScreen(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PreHomeScreen(),
              ),
            );
          }
        }
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
