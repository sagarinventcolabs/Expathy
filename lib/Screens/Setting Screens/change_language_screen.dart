import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Models/flag_model.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/svg_picture.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  List<FlagModel> flagList = [
    FlagModel(image: AppImages.f6, name: 'English'),
    FlagModel(image: AppImages.f7, name: 'Español'),
    FlagModel(image: AppImages.f17, name: 'العربية'),
    FlagModel(image: AppImages.f13, name: 'Polski'),
    FlagModel(image: AppImages.f1, name: 'Turkce'),
    FlagModel(image: AppImages.f9, name: 'Farsi'),
    FlagModel(image: AppImages.f11, name: 'हिन्दी'),
    FlagModel(image: AppImages.f5, name: 'Deutsch'),
    FlagModel(image: AppImages.f2, name: 'Português'),
    FlagModel(image: AppImages.f12, name: 'Italiano'),
    FlagModel(image: AppImages.f3, name: 'Portugese'),
    FlagModel(image: AppImages.f14, name: 'Română'),
    FlagModel(image: AppImages.f15, name: 'Ελληνικά'),
    FlagModel(image: AppImages.f4, name: 'Čeština'),
    FlagModel(image: AppImages.f10, name: 'Hrvatski'),
    FlagModel(image: AppImages.f8, name: 'Magyar'),
    FlagModel(image: AppImages.f16, name: 'български'),
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
                              top: 32.0, right: 16, left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Center(
                                child: TextWidget(
                                  text: 'Change Language',
                                  color: AppColors.black,
                                  fontSize: 24,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              heightGap(16),
                              Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final flagData = flagList[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              flagData.isSelected =
                                                  !flagData.isSelected;
                                            });
                                          },
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: flagData.isSelected
                                                  ? AppColors.yellow
                                                  : AppColors.white,
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.borderColor),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    flagData.image ?? '',
                                                    width: 33,
                                                    height: 24,
                                                  ),
                                                  widthGap(10),
                                                  TextWidget(
                                                    text: flagData.name ?? '',
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14,
                                                    color: AppColors.black,
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return heightGap(10);
                                    },
                                    itemCount: flagList.length),
                              ),
                              heightGap(16),
                              ElevatedButtonWidget(
                                  onPressed: () {}, text: 'Change'),
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
