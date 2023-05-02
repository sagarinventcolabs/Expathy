import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_form_field_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/toolbar_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                                      text: 'Personal Details',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppFonts.poppins),
                                ),
                                heightGap(28),
                                const TextFormFieldWidget(
                                  hintText: 'User name',
                                ),
                                heightGap(16),
                                const TextFormFieldWidget(
                                  hintText: 'Email',
                                ),
                                heightGap(32),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth(context) * 0.10),
                                  child: ElevatedButtonWidget(
                                      onPressed: () {}, text: 'Save'),
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
