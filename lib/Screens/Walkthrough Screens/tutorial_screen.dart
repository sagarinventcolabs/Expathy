import 'package:expathy/Screens/Auth%20Screens/prehome_screen.dart';
import 'package:expathy/Screens/Auth%20Screens/sign_up_screen.dart';
import 'package:expathy/Custom%20Painter%20/walkthrough_custom_painter.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Models/on_boarding_model.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/svg_picture.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _imageController = PageController(initialPage: 0);
  int pageChangeIndex = 0;
  int imageChangeIndex = 0;

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(AppImages.walk1, "Answer the questions",
        "This is important to match you with our licensed therapists."),
    OnBoardingModel(AppImages.walk2, "Select your therapist",
        "Select one of our licensed therapists based on their expertise."),
    OnBoardingModel(AppImages.walk3, "Book the free session and start soon",
        "Don't wait for the waiting list and reach to the therapist immediately by free session"),
  ];

  List<String> onBoardingImageList = [
    AppImages.walk1,
    AppImages.walk2,
    AppImages.walk3,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.white,
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: onBoardingList.length,
              onPageChanged: (value) {
                setState(() {
                  pageChangeIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return SvgPic(
                  image: onBoardingList[index].image ?? '',
                  fit: BoxFit.contain,
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomPaint(
                size: Size(
                    deviceWidth(context),
                    (deviceHeight(context) * 0.65)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: WalkthroughCustomPainter(),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ));
                        },
                        child: const TextWidget(
                          text: AppStrings.skip,
                          color: AppColors.black,
                          fontSize: 20,
                          fontFamily: AppFonts.tajawal,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: onBoardingList.length,
                    onPageChanged: (value) {
                      setState(() {
                        pageChangeIndex = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            right: deviceWidth(context) * 0.06,
                            left: deviceWidth(context) * 0.06,
                            top: deviceHeight(context) * 0.01),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: SvgPic(
                                  image: onBoardingList[index].image ?? '',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    text: onBoardingList[index].heading ?? '',
                                    color: AppColors.white,
                                    fontSize: 28,
                                    textAlign: TextAlign.center,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  heightGap(12),
                                  TextWidget(
                                    text: onBoardingList[index].title ?? '',
                                    color: AppColors.white,
                                    fontSize: 18,
                                    textAlign: TextAlign.center,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (pageChangeIndex != 0)
                        InkWell(
                          onTap: () {
                            previousPage();
                          },
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.white,
                            ),
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: pageChangeIndex == 0
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.center,
                          children: List.generate(
                            onBoardingList.length,
                            (indexDots) {
                              return Container(
                                margin: const EdgeInsets.only(right: 3),
                                height: 3,
                                width: pageChangeIndex == indexDots ? 42 : 4,
                                decoration: BoxDecoration(
                                    color: pageChangeIndex == indexDots
                                        ? AppColors.yellow
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              );
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          nextPage();
                        },
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.white,
                          ),
                          child: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void nextPage() {
    setState(() {
      if (pageChangeIndex < 2) {
        pageChangeIndex++;
        _pageController.animateToPage(pageChangeIndex,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PreHomeScreen(),
        ));
      }
    });
  }

  void previousPage() {
    setState(() {
      if (pageChangeIndex > 0) {
        pageChangeIndex--;
        _pageController.animateToPage(pageChangeIndex,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }
}
