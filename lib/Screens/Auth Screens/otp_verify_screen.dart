import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_form_field_widget.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/toolbar_widget.dart';
import 'login_screen.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              /*const SvgPic(
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 20),
                    child: ToolBarWidget(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Image.asset(
                    AppImages.logo,
                    width: deviceWidth(context) * 0.40,
                    height: deviceHeight(context) * 0.15,
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
                                      text: 'OTP Verification',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.poppins),
                                ),
                                heightGap(28),
                                PinCodeTextField(
                                  length: 6,
                                  obscureText: false,
                                  animationType: AnimationType.fade,
                                  cursorColor: AppColors.greyText,
                                  cursorHeight: 10,
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: AppFonts.poppins,
                                      color: AppColors.greyText),
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 40,
                                    fieldWidth: 45,
                                    activeFillColor: Colors.white,
                                    selectedColor: AppColors.greyText,
                                    selectedFillColor: AppColors.white,
                                    inactiveFillColor: AppColors.white,
                                    inactiveColor: AppColors.greyText,
                                    activeColor: AppColors.greyText,
                                    borderWidth: 0.5,
                                    disabledColor: AppColors.greyText,
                                  ),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  onCompleted: (v) {
                                    print("Completed");
                                  },
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      // currentText = value;
                                    });
                                  },
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");
                                    return true;
                                  },
                                  appContext: context,
                                ),
                                heightGap(32),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth(context) * 0.10),
                                  child: ElevatedButtonWidget(
                                      onPressed: () {}, text: 'Verify OTP'),
                                ),
                                heightGap(20),
                                conditionWidget(
                                    title: 'Already have an account?',
                                    heading: 'Login',
                                    navigateToLogin: true,
                                    showCheckBox: false,
                                    textAlign: TextAlign.center,
                                    decoration: TextDecoration.underline),
                                heightGap(20),
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

  Widget conditionWidget(
      {bool showCheckBox = true,
      String? title,
      Key? key,
      String? heading,
      bool navigateToLogin = false,
      TextAlign textAlign = TextAlign.start,
      TextDecoration decoration = TextDecoration.none}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    ..onTap = () {
                      if (navigateToLogin) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      }
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
