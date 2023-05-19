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
import '../../Widgets/svg_picture.dart';
import '../../Widgets/toolbar_widget.dart';
import '../Auth Screens/sign_up_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool makeSetPassword;
  const ChangePasswordScreen({Key? key, this.makeSetPassword = false})
      : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final newPasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();

  bool currentPasswordObSecure = true;
  bool newPasswordObSecure = true;
  bool reEnterPasswordObSecure = true;

  final _formKey = GlobalKey<FormState>();
  bool isSetPassword = false;
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
                  Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: deviceWidth(context) * 0.40,
                          height: deviceHeight(context) * 0.15,
                          child: const SvgPic(
                            image: AppImages.logoMain,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 20,
                        child: ToolBarWidget(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
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
                                        text: widget.makeSetPassword
                                            ? 'Set Password'
                                            : AppLocalizations.of(context)!
                                                .changePassword,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppFonts.poppins),
                                  ),
                                  heightGap(28),
                                  if (!widget.makeSetPassword)
                                    TextFormFieldWidget(
                                      hintText: AppLocalizations.of(context)!
                                          .currentPassword,
                                      controller: currentPasswordController,
                                      obscureText: currentPasswordObSecure,
                                      isPassword: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter current password';
                                        } else if (value.length < 6) {
                                          return 'Please enter minimum 6 digit password';
                                        }
                                        return null;
                                      },
                                      onVisibilityIconTap: () {
                                        setState(() {
                                          currentPasswordObSecure =
                                              !currentPasswordObSecure;
                                        });
                                      },
                                    ),
                                  if (!widget.makeSetPassword) heightGap(16),
                                  TextFormFieldWidget(
                                    hintText: AppLocalizations.of(context)!
                                        .newPassword,
                                    controller: newPasswordController,
                                    obscureText: newPasswordObSecure,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter new password';
                                      } else if (value.length < 6) {
                                        return 'Please enter minimum 6 digit password';
                                      }
                                      return null;
                                    },
                                    onVisibilityIconTap: () {
                                      setState(() {
                                        newPasswordObSecure =
                                            !newPasswordObSecure;
                                      });
                                    },
                                  ),
                                  heightGap(16),
                                  TextFormFieldWidget(
                                    hintText: AppLocalizations.of(context)!
                                        .reEnterPassword,
                                    controller: reEnterPasswordController,
                                    obscureText: reEnterPasswordObSecure,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please re-enter password';
                                      } else if (newPasswordController.text !=
                                          reEnterPasswordController.text) {
                                        return 'Re-enter password not match with new password';
                                      }
                                      return null;
                                    },
                                    onVisibilityIconTap: () {
                                      setState(() {
                                        reEnterPasswordObSecure =
                                            !reEnterPasswordObSecure;
                                      });
                                    },
                                  ),
                                  heightGap(32),
                                  isSetPassword
                                      ? const Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  deviceWidth(context) * 0.10),
                                          child: ElevatedButtonWidget(
                                            onPressed: () {
                                              if (widget.makeSetPassword) {
                                                callSetPasswordApi(
                                                    authProvider: authProvider);
                                              } else {
                                                callChangePasswordApi(
                                                    authProvider: authProvider);
                                              }
                                            },
                                            text: AppLocalizations.of(context)!
                                                .save,
                                          ),
                                        ),
                                  heightGap(20),
                                  /*  if (widget.makeSetPassword)
                                    conditionWidget(
                                        title: 'Don’t have account?',
                                        heading: 'Create Account',
                                        showCheckBox: false,
                                        textAlign: TextAlign.center,
                                        decoration: TextDecoration.underline),
                                  if (widget.makeSetPassword) heightGap(20),*/
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

  Future<void> callSetPasswordApi({required AuthProvider authProvider}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSetPassword = true;
      });
      await authProvider.resetPasswordApi(
        context: context,
        email: authProvider.getEmail.toString(),
        password: newPasswordController.text,
      );
      setState(() {
        isSetPassword = false;
      });
    }
  }

  Future<void> callChangePasswordApi(
      {required AuthProvider authProvider}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSetPassword = true;
      });
      await authProvider.changePasswordApi(
        context: context,
        password: currentPasswordController.text,
        newPassword: newPasswordController.text,
      );
      setState(() {
        isSetPassword = false;
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
