import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/svg_picture.dart';

class BuddyScreen extends StatefulWidget {
  const BuddyScreen({Key? key}) : super(key: key);

  @override
  State<BuddyScreen> createState() => _BuddyScreenState();
}

class _BuddyScreenState extends State<BuddyScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10.0),
          child: Column(
            children: [
              ToolBarWidget(
                  onTap: () {}, title: 'Gossips', showArrowIcon: false),
              heightGap(20),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 20,
                        right: 20.0,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SvgPic(
                                image: AppImages.buddyImage,
                                fit: BoxFit.contain),
                            heightGap(10),
                            SizedBox(
                              width: deviceWidth(context) * 0.70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const TextWidget(
                                    text:
                                        "We know that you are NOT alone. Expathy will find a mental buddy right now.",
                                    color: AppColors.black,
                                    textAlign: TextAlign.center,
                                    fontSize: 16,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  heightGap(20),
                                  SizedBox(
                                    height: 48,
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const SvgPic(
                                          image: AppImages.butterfly),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      label: const TextWidget(
                                        text: "Click here",
                                        textAlign: TextAlign.center,
                                        color: AppColors.white,
                                        fontFamily: AppFonts.poppins,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            heightGap(10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
