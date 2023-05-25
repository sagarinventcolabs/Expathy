import 'package:dotted_border/dotted_border.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({Key? key}) : super(key: key);

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  List<String> list = [
    AppImages.email,
    AppImages.linkdin,
    AppImages.whatsapp,
    AppImages.fb,
    AppImages.insta,
    AppImages.twitter,
  ];

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
                              Center(
                                child: TextWidget(
                                  text: AppLocalizations.of(context)!
                                      .inviteFriends,
                                  color: AppColors.black,
                                  fontSize: 24,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              heightGap(16),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.checkBoxBorderColor,
                                      blurRadius: 1.0,
                                      offset: Offset(
                                        1,
                                        1,
                                      ),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: Column(
                                    children: [
                                      TextWidget(
                                        text: AppLocalizations.of(context)!
                                            .shareYourCodeWithYourFriends,
                                        color: AppColors.black,
                                        fontSize: 17,
                                        fontFamily: AppFonts.tajawal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      heightGap(10),
                                      DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(8),
                                        dashPattern: const [6, 6],
                                        color: AppColors.greenLight,
                                        strokeWidth: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8,
                                              ),
                                              color: AppColors.greenExtraLight),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 10),
                                            child: TextWidget(
                                              text: 'REFERCODE!',
                                              color: AppColors.greenLight,
                                              fontSize: 17,
                                              fontFamily: AppFonts.tajawal,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              heightGap(20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextWidget(
                                  text: AppLocalizations.of(context)!.inviteBy,
                                  color: AppColors.black,
                                  fontSize: 18,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              heightGap(20),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: GridView.builder(
                                    itemCount: list.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  AppColors.checkBoxBorderColor,
                                              blurRadius: 1.0,
                                              offset: Offset(
                                                1,
                                                1,
                                              ),
                                            )
                                          ],
                                        ),
                                        child: SvgPic(image: list[index]),
                                      );
                                    },
                                  ),
                                ),
                              )
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
}
