import 'package:expathy/Providers/Question%20Provider/question_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /question_screen_custom_painter.dart';
import '../../Models/first_question_model.dart';
import '../../Models/questions_model.dart';
import '../../Remote/app_exceptions.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/skeleton_widget.dart';

class FirstQuestionScreen extends StatefulWidget {
  const FirstQuestionScreen({Key? key}) : super(key: key);

  @override
  State<FirstQuestionScreen> createState() => _FirstQuestionScreenState();
}

class _FirstQuestionScreenState extends State<FirstQuestionScreen> {
  int questionIndex = 0;
  double barPercentage = 0.1;
  String? selectedLanguage;
  late Future<FirstQuestionModel?> firstFuture;

  @override
  void initState() {
    super.initState();
    firstFuture = context.read<QuestionProvider>().fetchFirstQuestionApi(
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomPaint(
                        size: Size(deviceWidth(context),
                            (deviceHeight(context) * 0.30).toDouble()),
                        painter: QuestionScreenCustomPainter(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20.0, left: 20, right: 20),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 65,
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppImages.logo,
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(100),
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightGap(14),
                    const TextWidget(
                      text: 'Let\'s Start...',
                      fontSize: 18,
                      color: AppColors.white,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w400,
                    ),
                    heightGap(18),
                    LinearPercentIndicator(
                      lineHeight: 10,
                      percent: barPercentage,
                      barRadius: const Radius.circular(16),
                      progressColor: AppColors.yellow,
                      backgroundColor: AppColors.questionBarBg,
                    ),
                    heightGap(30),
                    /*  Expanded(
                      child: FutureBuilder(
                        future: firstFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return loadingShimmer();
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              if (snapshot.error is NoInternetException) {
                                NoInternetException noInternetException =
                                    snapshot.error as NoInternetException;
                                return Center(
                                  child: Lottie.asset(AppImages.oppsJson,
                                      width: 200, height: 200),
                                );
                              }
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            } else if (snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: TextWidget(
                                      text: snapshot.data?.data?.question ?? '',
                                      fontSize: 22,
                                      textAlign: TextAlign.center,
                                      color: AppColors.white,
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  heightGap(30),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          ...?snapshot.data?.data?.options
                                              ?.map((answer) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedLanguage = answer;
                                                  });
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: answer ==
                                                            selectedLanguage
                                                        ? AppColors.yellow
                                                        : AppColors.white,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .borderColor),
                                                  ),
                                                  child: Center(
                                                    child: TextWidget(
                                                      text: answer,
                                                      textAlign:
                                                          TextAlign.center,
                                                      fontSize: 14,
                                                      color: answer ==
                                                              selectedLanguage
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                      fontFamily:
                                                          AppFonts.poppins,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: Lottie.asset(AppImages.emptyJson,
                                    width: 300, height: 300),
                              );
                            }
                          } else {
                            return Center(
                                child:
                                    Text('State: ${snapshot.connectionState}'));
                          }
                        },
                      ),
                    ),*/
                    Expanded(
                      child: CustomFutureBuilder<FirstQuestionModel?>(
                        loaderWidget: loadingShimmer(),
                        future: firstFuture,
                        data: (snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: TextWidget(
                                  text: snapshot?.data?.question ?? '',
                                  fontSize: 22,
                                  textAlign: TextAlign.center,
                                  color: AppColors.white,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              heightGap(30),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      ...?snapshot?.data?.options
                                          ?.map((answer) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedLanguage = answer;
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
                                                color:
                                                    answer == selectedLanguage
                                                        ? AppColors.yellow
                                                        : AppColors.white,
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        AppColors.borderColor),
                                              ),
                                              child: Center(
                                                child: TextWidget(
                                                  text: answer,
                                                  textAlign: TextAlign.center,
                                                  fontSize: 14,
                                                  color:
                                                      answer == selectedLanguage
                                                          ? AppColors.white
                                                          : AppColors.black,
                                                  fontFamily: AppFonts.poppins,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingShimmer() {
    return Column(
      children: [
        heightGap(20),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: shimmerEffect(
                  widget: const SkeletonWidget(
                    radius: 30,
                    height: 40,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
