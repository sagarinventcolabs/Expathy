import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Custom%20Painter%20/auth_screen_painter.dart';
import 'package:expathy/Screens/Auth%20Screens/login_screen.dart';
import 'package:expathy/Screens/Auth%20Screens/sign_up_screen.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Widgets/svg_picture.dart';

class PreHomeScreen extends StatefulWidget {
  const PreHomeScreen({Key? key}) : super(key: key);

  @override
  State<PreHomeScreen> createState() => _PreHomeScreenState();
}

class _PreHomeScreenState extends State<PreHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(deviceWidth(context),
                    (deviceHeight(context) * 0.50).toDouble()),
                painter: AuthScreenPainter(),
              ),
              Column(
                children: [
                  SizedBox(
                    width: deviceWidth(context) * 0.40,
                    height: deviceHeight(context) * 0.15,
                    child: const SvgPic(
                      image: AppImages.logoMain,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, right: 16, left: 16),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                containerItem(
                                  text: 'Sign up with Email',
                                  textColor: AppColors.blue,
                                  iconColor: AppColors.blue,
                                  icon: Icons.email_outlined,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen(),
                                        ));
                                  },
                                ),
                                heightGap(20),
                                divider(),
                                heightGap(20),
                                containerItem(
                                  text: 'Sign up with Google',
                                  image: AppImages.google,
                                  onTap: () {},
                                ),
                                heightGap(30),
                                containerItem(
                                    text: 'Sign up with Apple',
                                    image: AppImages.apple,
                                    onTap: () {}),
                                heightGap(30),
                                containerItem(
                                    text: 'Sign up with Facebook',
                                    image: AppImages.facebook,
                                    onTap: () {}),
                                heightGap(40),
                                conditionWidget(
                                    title: 'Already have an account?',
                                    heading: 'Login',
                                    showCheckBox: false,
                                    textAlign: TextAlign.center,
                                    decoration: TextDecoration.underline),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerItem(
      {String? text,
      String? image,
      IconData? icon,
      Color? iconColor,
      required Function() onTap,
      Color? textColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.borderColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            image == null
                ? Icon(
                    icon,
                    color: iconColor,
                  )
                : SvgPic(image: image),
            widthGap(10),
            TextWidget(
              text: text ?? '',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: textColor ?? AppColors.black,
              fontFamily: AppFonts.poppins,
            ),
          ]),
        ),
      ),
    );
  }

  Widget conditionWidget(
      {bool showCheckBox = true,
      String? title,
      Key? key,
      String? heading,
      TextAlign textAlign = TextAlign.start,
      TextDecoration decoration = TextDecoration.none}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          textAlign: textAlign,
          TextSpan(
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.poppins,
                color: AppColors.black),
            children: [
              TextSpan(
                text: title ?? '',
              ),
              const WidgetSpan(child: SizedBox(width: 3)),
              TextSpan(
                text: heading ?? '',
                style: TextStyle(color: AppColors.blue, decoration: decoration),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
