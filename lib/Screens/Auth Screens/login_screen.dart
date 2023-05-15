import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Common%20Widgets/text_form_field_widget.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Screens/Auth%20Screens/forgot_password_screen.dart';
import 'package:expathy/Screens/Auth%20Screens/sign_up_screen.dart';
import 'package:expathy/Screens/Question%20Answer%20Screen/question_answer_screen.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Providers/Auth Provider/auth_provider.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Widgets/svg_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Question Answer Screen/first_question_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMeCheckBoxChecked = false;
  bool passwordObSecure = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = false;

  @override
  void initState() {
    emailController.text =
        sharedPrefs?.getString(AppStrings.rememberMeEmail) ?? '';
    passwordController.text =
        sharedPrefs?.getString(AppStrings.rememberMePassword) ?? '';
    super.initState();
  }

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
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Center(
                                    child: TextWidget(
                                      text: 'Login',
                                      color: AppColors.black,
                                      fontSize: 28,
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  heightGap(16),
                                  TextFormFieldWidget(
                                    hintText: 'Email',
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter email';
                                      } else if (!RegExp(emailPattern)
                                          .hasMatch(value)) {
                                        return 'Please enter valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  heightGap(16),
                                  TextFormFieldWidget(
                                    hintText: 'Password',
                                    controller: passwordController,
                                    obscureText: passwordObSecure,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                    onVisibilityIconTap: () {
                                      setState(() {
                                        passwordObSecure = !passwordObSecure;
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordScreen(),
                                          ));
                                        },
                                        child: const TextWidget(
                                            text: 'Forgot Password?',
                                            color: AppColors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                  heightGap(20),
                                  isLogin
                                      ? const Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  deviceWidth(context) * 0.10),
                                          child: ElevatedButtonWidget(
                                              onPressed: () async {
                                                await callLoginApi(
                                                    authProvider: authProvider);
                                              },
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .login),
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
                                      socialContainer(
                                          image: AppImages.facebook),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> callLoginApi({required AuthProvider authProvider}) async {
    if (_formKey.currentState!.validate()) {
      if (isRememberMeCheckBoxChecked) {
        sharedPrefs?.setString(
            AppStrings.rememberMeEmail, emailController.text.trim());
        sharedPrefs?.setString(
            AppStrings.rememberMePassword, passwordController.text);
      }
      setState(() {
        isLogin = true;
      });
      /* await authProvider.loginApi(
        email: emailController.text.trim(),
        password: passwordController.text,
        type: 'Expact',
        context: context,
      );*/
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const QuestionAnswerScreen(),
        ),
      );
      setState(() {
        isLogin = false;
      });
    }
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
