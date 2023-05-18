import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Common%20Widgets/text_form_field_widget.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Providers/Auth%20Provider/auth_provider.dart';
import 'package:expathy/Screens/Auth%20Screens/login_screen.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Widgets/svg_picture.dart';
import '../Setting Screens/personal_information_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isTermsCheckBoxChecked = false;
  bool isPrivacyCheckBoxChecked = false;
  bool passwordObSecure = true;
  bool confirmPasswordObSecure = true;
  bool isSignUp = false;
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
                            physics: const BouncingScrollPhysics(),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Center(
                                    child: TextWidget(
                                      text:
                                          AppLocalizations.of(context)!.signUp,
                                      color: AppColors.black,
                                      fontSize: 28,
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  heightGap(16),
                                  TextFormFieldWidget(
                                    hintText:
                                        AppLocalizations.of(context)!.userName,
                                    controller: userNameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter user name';
                                      }
                                      return null;
                                    },
                                  ),
                                  heightGap(16),
                                  TextFormFieldWidget(
                                    hintText:
                                        AppLocalizations.of(context)!.email,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
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
                                    hintText:
                                        AppLocalizations.of(context)!.password,
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
                                  heightGap(16),
                                  TextFormFieldWidget(
                                    hintText: AppLocalizations.of(context)!
                                        .confirmPassword,
                                    controller: confirmPasswordController,
                                    obscureText: confirmPasswordObSecure,
                                    isPassword: true,
                                    onVisibilityIconTap: () {
                                      setState(() {
                                        confirmPasswordObSecure =
                                            !confirmPasswordObSecure;
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter confirm password';
                                      } else if (passwordController.text !=
                                          confirmPasswordController.text) {
                                        return 'Confirm password not match with password';
                                      }
                                      return null;
                                    },
                                  ),
                                  heightGap(20),
                                  conditionWidget(
                                      title: AppLocalizations.of(context)!
                                          .iHaveReadAndAcceptThe,
                                      heading: AppLocalizations.of(context)!
                                          .termAndConditions,
                                      key: const Key('1'),
                                      navigateToTermsAndCondition: true),
                                  heightGap(16),
                                  conditionWidget(
                                      title: AppLocalizations.of(context)!
                                          .iHaveReadAndAcceptThe,
                                      heading: AppLocalizations.of(context)!
                                          .privacyPolicy,
                                      key: const Key('2'),
                                      navigateToPrivacyPolicy: true),
                                  heightGap(20),
                                  isSignUp
                                      ? const Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  deviceWidth(context) * 0.10),
                                          child: ElevatedButtonWidget(
                                            onPressed: () async {
                                              await callSignUpApi(
                                                  authProvider: authProvider);
                                            },
                                            text: AppLocalizations.of(context)!
                                                .signUp,
                                          ),
                                        ),
                                  heightGap(16),
                                  conditionWidget(
                                      title: AppLocalizations.of(context)!
                                          .alreadyHaveAnAccount,
                                      heading:
                                          AppLocalizations.of(context)!.login,
                                      navigateToLogin: true,
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

  Future<void> callSignUpApi({required AuthProvider authProvider}) async {
    if (_formKey.currentState!.validate()) {
      if (!isTermsCheckBoxChecked) {
        showSnackBar(
            context: context,
            message: 'please select terms & conditions',
            isSuccess: false);
      } else if (!isPrivacyCheckBoxChecked) {
        showSnackBar(
            context: context,
            message: 'please select privacy policy',
            isSuccess: false);
      } else {
        setState(() {
          isSignUp = true;
        });
        await authProvider.signUpApi(
          email: emailController.text.trim(),
          userName: userNameController.text.trim().toString(),
          password: passwordController.text,
          type: 'Expact',
          loginType: 'Email',
          context: context,
        );
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuestionAnswerScreen(),
          ),
        );*/

        setState(() {
          isSignUp = false;
        });
      }
    }
  }

  Widget conditionWidget(
      {bool showCheckBox = true,
      String? title,
      Key? key,
      String? heading,
      bool navigateToLogin = false,
      bool navigateToTermsAndCondition = false,
      bool navigateToPrivacyPolicy = false,
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
                if (key == const Key('1')) {
                  isTermsCheckBoxChecked = !isTermsCheckBoxChecked;
                } else {
                  isPrivacyCheckBoxChecked = !isPrivacyCheckBoxChecked;
                }
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
              child: key == const Key('1')
                  ? isTermsCheckBoxChecked
                      ? const Icon(Icons.check)
                      : const SizedBox()
                  : isPrivacyCheckBoxChecked
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
                    ..onTap = () {
                      if (navigateToLogin) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      } else if (navigateToTermsAndCondition) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PersonalInformationScreen(
                                      type: 'Terms of Use'),
                            ));
                      } else if (navigateToPrivacyPolicy) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PersonalInformationScreen(
                                      type: 'Privacy Policy'),
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
