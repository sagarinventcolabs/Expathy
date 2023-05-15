import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Providers/Auth Provider/auth_provider.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/toolbar_widget.dart';
import '../Setting Screens/change_password_screen.dart';
import 'login_screen.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String? otp;
  final _formKey = GlobalKey<FormState>();
  bool isVerifyOtp = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
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
                            child: Form(
                              key: _formKey,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: PinCodeTextField(
                                      length: 4,
                                      obscureText: false,
                                      animationType: AnimationType.fade,
                                      cursorColor: AppColors.greyText,
                                      cursorHeight: 10,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please fill OTP';
                                        } else if (value.length < 4) {
                                          return 'OTP must be 4 digit';
                                        }
                                        return null;
                                      },
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppFonts.poppins,
                                          color: AppColors.greyText),
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 45,
                                        fieldWidth: 55,
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
                                        log("Completed");
                                      },
                                      onChanged: (value) {
                                        log(value);
                                        setState(() {
                                          otp = value;
                                        });
                                      },
                                      beforeTextPaste: (text) {
                                        log("Allowing to paste $text");
                                        return true;
                                      },
                                      appContext: context,
                                    ),
                                  ),
                                  heightGap(32),
                                  isVerifyOtp
                                      ? const Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  deviceWidth(context) * 0.10),
                                          child: ElevatedButtonWidget(
                                              onPressed: () async {
                                                await callVerifyOtpApi(
                                                    authProvider: authProvider);
                                              },
                                              text: 'Verify OTP'),
                                        ),
                                  heightGap(20),
                                  /*  conditionWidget(
                                      title: 'Already have an account?',
                                      heading: 'Login',
                                      navigateToLogin: true,
                                      showCheckBox: false,
                                      textAlign: TextAlign.center,
                                      decoration: TextDecoration.underline),
                                  heightGap(20),*/
                                ],
                              ),
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

  Future<void> callVerifyOtpApi({required AuthProvider authProvider}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isVerifyOtp = true;
      });
      /* await authProvider.verifyOtpApi(
        context: context,
        email: authProvider.getEmail.toString(),
        otp: otp ?? '',
      );*/
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const ChangePasswordScreen(makeSetPassword: true),
        ),
      );

      setState(() {
        isVerifyOtp = false;
      });
    }
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
