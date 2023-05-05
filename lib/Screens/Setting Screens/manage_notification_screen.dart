import 'package:flutter/material.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/svg_picture.dart';
import '../../Widgets/toolbar_widget.dart';

class ManageNotificationScreen extends StatefulWidget {
  const ManageNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ManageNotificationScreen> createState() =>
      _ManageNotificationScreenState();
}

class _ManageNotificationScreenState extends State<ManageNotificationScreen> {
  @override
  Widget build(BuildContext context) {
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
                              top: 20.0, right: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Center(
                                child: TextWidget(
                                  text: 'Manage Notifications',
                                  color: AppColors.black,
                                  fontSize: 24,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              heightGap(16),
                              rowItem(
                                  title: 'Notifications',
                                  heading:
                                      'This will not affect any session updates'),
                              heightGap(16),
                              divider(),
                              heightGap(16),
                              rowItem(
                                  title: 'Optimized Experience',
                                  heading: 'For internet connection quality'),
                              heightGap(16),
                              rowItem(
                                title: 'Optimized Image Quality',
                              ),
                              heightGap(16),
                              rowItem(
                                title: 'Optimized Checkout Flow',
                              ),
                              heightGap(16),
                              divider(),
                              heightGap(16),
                              rowItem(
                                  title: 'Lorem ipsum',
                                  heading:
                                      'This will not affect any session updates'),
                            ],
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

  Widget rowItem({String? title, String? heading}) {
    return Row(children: [
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextWidget(
            text: title ?? '',
            fontSize: 16,
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w400,
          ),
          TextWidget(
            text: heading ?? '',
            color: AppColors.greyText,
            fontSize: 14,
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w300,
          ),
        ]),
      ),
      Checkbox(
        value: true,
        activeColor: AppColors.greenLight,
        onChanged: (value) {},
      ),
    ]);
  }

  Widget divider() {
    return const Divider(
      color: AppColors.checkBoxBorderColor,
      height: 2,
      indent: 10,
      endIndent: 10,
    );
  }
}
