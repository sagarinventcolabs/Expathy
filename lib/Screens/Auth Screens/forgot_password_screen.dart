import 'package:expathy/Screens/Auth%20Screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_form_field_widget.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Providers/Auth Provider/auth_provider.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/toolbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isSendOtp = false;
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
                                  Center(
                                    child: TextWidget(
                                        text: AppLocalizations.of(context)!
                                            .forgotPassword,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFonts.poppins),
                                  ),
                                  heightGap(28),
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
                                  heightGap(32),
                                  isSendOtp
                                      ? const Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  deviceWidth(context) * 0.10),
                                          child: ElevatedButtonWidget(
                                            onPressed: () {
                                              callForgotPasswordApi(
                                                  authProvider: authProvider);
                                            },
                                            text: AppLocalizations.of(context)!
                                                .sendOtp,
                                          ),
                                        ),
                                  heightGap(20),
                                  /*conditionWidget(
                                      title: 'Don’t have account?',
                                      heading: 'Create Account',
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

  Future<void> callForgotPasswordApi(
      {required AuthProvider authProvider}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSendOtp = true;
      });
      authProvider.setEmail = emailController.text.toString();
      await authProvider.forgotPasswordApi(
        email: emailController.text.trim(),
        context: context,
      );
      /* Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OtpVerifyScreen(),
        ),
      );*/

      setState(() {
        isSendOtp = false;
      });
    }
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
