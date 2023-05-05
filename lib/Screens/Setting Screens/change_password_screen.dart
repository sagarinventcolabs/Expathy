import 'package:flutter/material.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_form_field_widget.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/toolbar_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

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
                                      text: 'Change Password',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.poppins),
                                ),
                                heightGap(28),
                                const TextFormFieldWidget(
                                  hintText: 'Current Password',
                                ),
                                heightGap(16),
                                const TextFormFieldWidget(
                                  hintText: 'New Password',
                                ),
                                heightGap(16),
                                const TextFormFieldWidget(
                                  hintText: 'Re-enter Password',
                                ),
                                heightGap(32),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth(context) * 0.10),
                                  child: ElevatedButtonWidget(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      text: 'Save'),
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
}
