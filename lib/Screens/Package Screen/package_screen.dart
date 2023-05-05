import 'package:carousel_slider/carousel_slider.dart';
import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Models/benefits_model.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:expathy/Widgets/underline_text_widget.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/text_widget.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  List<BenefitsModel> benefitsList = [
    BenefitsModel(
      heading: 'Cancel & Reschedule',
      description: 'Cancellation & Rescheduling before 24 hrs',
    ),
    BenefitsModel(
      heading: 'Video Session',
      description: '50 minutes for video session',
    ),
    BenefitsModel(
      heading: 'Video Session',
      description: '50 minutes for video session',
    ),
    BenefitsModel(
      heading: 'Video Session',
      description: '50 minutes for video session',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ToolBarWidget(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            title: 'Packages',
                          ),
                        ],
                      ),
                      heightGap(24),
                      const TextWidget(
                        text: 'Benefits includes:',
                        color: AppColors.white,
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      ListView.separated(
                        itemCount: benefitsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final benefits = benefitsList[index];
                          return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenLight,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Center(
                                      child: Icon(
                                    Icons.check,
                                    color: AppColors.white,
                                    size: 18,
                                  )),
                                ),
                                widthGap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: benefits.heading ?? '',
                                      color: AppColors.white,
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                    ),
                                    heightGap(2),
                                    TextWidget(
                                      text: benefits.description ?? '',
                                      color: AppColors.white,
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return heightGap(10);
                        },
                      ),
                      heightGap(30),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 320.0,
                          enlargeCenterPage: true,
                          scrollPhysics: const BouncingScrollPhysics(),
                          viewportFraction: 0.65,
                        ),
                        items: [1, 2, 3, 4, 5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const UnderLineText(
                                        text: 'Gold',
                                        fontSize: 32,
                                        textColor: AppColors.yellow,
                                      ),
                                      heightGap(30),
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            TextWidget(
                                              text: '€',
                                              fontSize: 42,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: AppFonts.poppins,
                                            ),
                                            TextWidget(
                                              text: '29.99',
                                              fontSize: 42,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: AppFonts.poppins,
                                            )
                                          ]),
                                      const TextWidget(
                                        text: 'per session',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFonts.poppins,
                                      ),
                                      heightGap(20),
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const TextWidget(
                                              text: 'save',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.greenDark,
                                              fontFamily: AppFonts.poppins,
                                            ),
                                            widthGap(5),
                                            const TextWidget(
                                              text: '€100',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.greenDark,
                                              fontFamily: AppFonts.poppins,
                                            )
                                          ]),
                                      heightGap(10),
                                      const TextWidget(
                                        text: '24 session',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFonts.poppins,
                                      ),
                                    ]),
                              );
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              TextWidget(
                                text: '24 Sessions in 6 months',
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              TextWidget(
                                text: '€ 719.16',
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ],
                          ),
                        ),
                        ElevatedButtonWidget(
                            onPressed: () {}, text: 'Purchased'),
                      ],
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
