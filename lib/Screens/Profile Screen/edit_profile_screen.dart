import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_form_field_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Providers/User Provider/user_provider.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/svg_picture.dart';
import '../../Widgets/toolbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  bool isProfileUpdate = false;

  @override
  void initState() {
    userNameController.text = sharedPrefs?.getString(AppStrings.userName) ?? '';
    emailController.text = sharedPrefs?.getString(AppStrings.email) ?? '';
    super.initState();
  }

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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: TextWidget(
                                      text: AppLocalizations.of(context)!
                                          .personalDetails,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.poppins),
                                ),
                                heightGap(28),
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
                                  hintText: AppLocalizations.of(context)!.email,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: false,
                                ),
                                heightGap(32),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth(context) * 0.10),
                                  child: isProfileUpdate
                                      ? const Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : ElevatedButtonWidget(
                                          onPressed: () {
                                            callUpdateProfileApi();
                                          },
                                          text: AppLocalizations.of(context)!
                                              .save,
                                        ),
                                ),
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

  Future<void> callUpdateProfileApi() async {
    setState(() {
      isProfileUpdate = true;
    });
    await context.read<UserProvider>().updateProfileApi(
          userName: userNameController.text.trim(),
          isFromEditProfileScreen: true,
          context: context,
        );
    setState(() {
      isProfileUpdate = false;
    });
  }
}
