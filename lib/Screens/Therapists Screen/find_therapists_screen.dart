import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Screens/Therapists%20Screen/therapists_list_screen.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /question_screen_custom_painter.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';

class FindTherapistsScreen extends StatefulWidget {
  const FindTherapistsScreen({Key? key}) : super(key: key);

  @override
  State<FindTherapistsScreen> createState() => _FindTherapistsScreenState();
}

class _FindTherapistsScreenState extends State<FindTherapistsScreen> {
  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const TherapistsListScreen(),
      ));
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: Column(
                        children: [
                          ToolBarWidget(
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          heightGap(10),
                          const Center(
                            child: SizedBox(
                              width: 250,
                              child: TextWidget(
                                text:
                                    'We match you with licensed therapists...',
                                textAlign: TextAlign.center,
                                fontSize: 22,
                                color: AppColors.white,
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          heightGap(25),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: deviceHeight(context) * 0.57,
                      child: Image.asset(
                        AppImages.findGif,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      /*  SvgPic(
                        image: AppImages.questionScreenBg,
                      ),*/
                      CustomPaint(
                        size: Size(
                            deviceWidth(context),
                            (deviceHeight(context) * 0.30)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: QuestionScreenCustomPainter(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.logo,
                              height: deviceHeight(context) * 0.12,
                            ),
                          ],
                        ),
                      ),
                    ],
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
