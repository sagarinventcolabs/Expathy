import 'package:flutter/material.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/info_widget.dart';
import '../../Widgets/toolbar_widget.dart';
import '../Therapists Screen/therapists_detail_screen.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

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
                          expertiseButton(),
                        ],
                      ),
                    ),
                  ),
                  heightGap(16),
                  const TextWidget(
                    text: 'Article',
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: Image.asset(
                                AppImages.article,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const TextWidget(
                            text:
                                'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
                            fontSize: 16,
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w500,
                          ),
                          heightGap(6),
                          const TextWidget(
                            text: '4 April 2023, Tuesday',
                            fontSize: 12,
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w400,
                          ),
                          heightGap(10),
                          const TextWidget(
                            text: 'Demystifying Panic Attacks',
                            fontSize: 19,
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w500,
                          ),
                          heightGap(10),
                          const TextWidget(
                            text:
                                'Anxiety is a normal part of life, and we experience it for various reasons and at different levels of intensity. Each person\'s experience of anxiety, as well as their coping mechanisms, are unique to them and the situation. Within this context, panic attacks can be described as intense and sudden bouts of anxiety1. The unpredictable and unusual nature of panic attacks can lead people to mistake them for physical disorders. To avoid experiencing another attack, people may try to steer clear of potential triggers. Unfortunately, this avoidance behavior can create a vicious cycle that only exacerbates panic attacks. The key to breaking this cycle is recognizing the symptoms of a panic attack and addressing them accordingly.',
                            fontSize: 14,
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyText,
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

  Widget expertiseButton() {
    return Row(children: [
      Expanded(
        child: ElevatedButtonWidget(
            onPressed: () {},
            elevation: 0,
            height: 40,
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
            height: 40,
            textColor: AppColors.black,
            text: 'Family Conflict',
            primary: AppColors.yellowLight),
      ),
    ]);
  }
}
