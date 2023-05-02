import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Common%20Widgets/text_form_field_widget.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Screens/Auth%20Screens/sign_up_screen.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Widgets/svg_picture.dart';
import '../Question Answer Screen/question_answer_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMeCheckBoxChecked = false;
  bool passwordObsecure = true;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              /* const SvgPic(
                image: AppImages.signUpHeader,
              ),*/
              CustomPaint(
                size: Size(
                    deviceWidth(context),
                    (deviceHeight(context) * 0.50)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Center(
                                  child: TextWidget(
                                    text: 'Login Screen',
                                    color: AppColors.black,
                                    fontSize: 28,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                heightGap(16),
                                const TextFormFieldWidget(
                                  hintText: 'Email',
                                ),
                                heightGap(16),
                                TextFormFieldWidget(
                                  hintText: 'Password',
                                  obscureText: passwordObsecure,
                                  isPassword: true,
                                  onVisibilityIconTap: () {
                                    setState(() {
                                      passwordObsecure = !passwordObsecure;
                                    });
                                  },
                                ),
                                heightGap(20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: conditionWidget(
                                        title: 'Remember Me',
                                      ),
                                    ),
                                    const TextWidget(
                                        text: 'Forgot Password?',
                                        color: AppColors.blue,
                                        decoration: TextDecoration.underline),
                                  ],
                                ),
                                heightGap(20),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth(context) * 0.10),
                                  child: ElevatedButtonWidget(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const QuestionAnswerScreen(),
                                            ));
                                      },
                                      text: 'Login'),
                                ),
                                heightGap(20),
                                divider(),
                                heightGap(20),
                                Row(
                                  children: [
                                    socialContainer(image: AppImages.google),
                                    widthGap(10),
                                    socialContainer(image: AppImages.apple),
                                    widthGap(10),
                                    socialContainer(image: AppImages.facebook),
                                  ],
                                ),
                                heightGap(20),
                                conditionWidget(
                                    title: 'Don’t have account?',
                                    heading: 'Create Account',
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

  Widget socialContainer({String? image}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderColor, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
          child: SvgPic(image: image ?? ''),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showCheckBox)
          InkWell(
            onTap: () {
              setState(() {
                isRememberMeCheckBoxChecked = !isRememberMeCheckBoxChecked;
              });
            },
            child: Container(
              key: key,
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.checkBoxBorderColor),
              ),
              child: isRememberMeCheckBoxChecked
                  ? const Icon(Icons.check)
                  : const SizedBox(),
            ),
          ),
        widthGap(10),
        Expanded(
          child: Text.rich(
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
                  style:
                      TextStyle(color: AppColors.blue, decoration: decoration),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
