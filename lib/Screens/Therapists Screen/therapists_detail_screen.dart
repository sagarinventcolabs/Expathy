import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:expathy/Widgets/underline_text_widget.dart';
import 'package:expathy/Widgets/view_all_row_widget.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/horzontal_two_button_widget.dart';
import '../../Widgets/info_widget.dart';

class TherapistsDetailScreen extends StatelessWidget {
  const TherapistsDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
          child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightGap(20),
                  ToolBarWidget(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    iconColor: AppColors.white,
                    title: 'Therapists Details',
                    titleColor: AppColors.white,
                  ),
                  heightGap(20),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 18,
                      ),
                      child: Column(
                        children: [
                          InfoWidget(
                            name: 'Norma Warren',
                            type: 'Biopsychologists',
                            description:
                                'Vestibsfevulum semwe acssscv fre porttitor...',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const TherapistsDetailScreen(),
                              ));
                            },
                          ),
                          heightGap(10),
                          HorizontalTwoButtonWidget(
                            text1: 'Free Session NOW',
                            text1Tap: () {},
                            text2: 'Book Full Session',
                            text2Tap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  heightGap(16),
                  const TextWidget(
                    text: 'Biography',
                    fontSize: 18,
                    color: AppColors.white,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const UnderLineText(text: 'Areas of Expertise'),
                          heightGap(10),
                          expertiseButton(),
                          heightGap(10),
                          expertiseButton(),
                          heightGap(10),
                          const UnderLineText(text: 'Education'),
                          heightGap(14),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return educationItem();
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                          ),
                          heightGap(30),
                          const UnderLineText(text: 'About'),
                          heightGap(12),
                          const TextWidget(
                            text:
                                'Donec vitae mi vulputate, suscipit urna in, malesuada nisl. Pellentesque laoreet pretium nisl, et pulvinar massa eleifend sed. Curabitur maximus mollis diam, vel varius sapien suscipit eget. Cras sollicitudin Read more',
                            fontSize: 14,
                            color: AppColors.greyText,
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w500,
                          ),
                          heightGap(24),
                          const ViewAllRowWidget(
                              text: 'Articles',
                              textColor: AppColors.black,
                              viewAllColor: AppColors.blue),
                          heightGap(8),
                          SizedBox(
                            height: 265,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: deviceWidth(context) * 0.70,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(12),
                                            topLeft: Radius.circular(12)),
                                        child: SizedBox(
                                          height: 150,
                                          child: Image.asset(
                                            AppImages.article,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                              text:
                                                  'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
                                              fontSize: 18,
                                              color: AppColors.black,
                                              fontFamily: AppFonts.poppins,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            heightGap(10),
                                            const TextWidget(
                                              text: '4 April 2023, Tuesday',
                                              textAlign: TextAlign.center,
                                              fontSize: 12,
                                              color: AppColors.greyText,
                                              fontFamily: AppFonts.poppins,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  heightGap(10),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget educationItem() {
    return Row(children: [
      Image.asset(AppImages.education),
      widthGap(10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Education',
              fontSize: 16,
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w500,
            ),
            heightGap(6),
            const TextWidget(
              text: 'Psychology Undergraduate',
              fontSize: 14,
              color: AppColors.greyText,
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    ]);
  }

  Widget expertiseButton() {
    return Row(children: [
      Expanded(
        child: ElevatedButtonWidget(
            onPressed: () {},
            elevation: 0,
            borderRadius: 30,
            fontSize: 13,
            textColor: AppColors.black,
            text: 'Family Conflict',
            primary: AppColors.yellowLight),
      ),
      widthGap(10),
      Expanded(
        child: ElevatedButtonWidget(
            onPressed: () {},
            elevation: 0,
            borderRadius: 30,
            fontSize: 13,
            textColor: AppColors.black,
            text: 'Family Conflict',
            primary: AppColors.yellowLight),
      ),
    ]);
  }
}
