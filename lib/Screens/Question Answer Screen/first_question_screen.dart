import 'package:expathy/Providers/Question%20Provider/question_provider.dart';
import 'package:expathy/Providers/User%20Provider/user_provider.dart';
import 'package:expathy/Screens/Question%20Answer%20Screen/question_answer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /question_screen_custom_painter.dart';
import '../../Models/language_list_model.dart';
import '../../Providers/Auth Provider/auth_provider.dart';
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
  String? selectedLanguageId;
  String? selectedLanguageCode;
  bool isProfileUpdate = false;
  late Future<LanguageListModel?> languageListFuture;

  @override
  void initState() {
    super.initState();
    languageListFuture = context.read<QuestionProvider>().fetchLanguageListApi(
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
                              onTap: () async {
                                await callUpdateProfileApi();
                              },
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.white,
                                ),
                                child: isProfileUpdate
                                    ? const Center(
                                        child: CupertinoActivityIndicator(
                                            color: AppColors.green),
                                      )
                                    : const Icon(Icons.arrow_forward),
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
                    Expanded(
                      child: CustomFutureBuilder<LanguageListModel?>(
                        loaderWidget: loadingShimmer(),
                        future: languageListFuture,
                        noInternetOnPressed: () {
                          setState(() {
                            languageListFuture = context
                                .read<QuestionProvider>()
                                .fetchLanguageListApi(
                                  context: context,
                                );
                          });
                        },
                        data: (snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: TextWidget(
                                  text: 'What is your native language?',
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
                                      ...?snapshot?.data?.data?.map((answer) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedLanguageId =
                                                    answer.id.toString();
                                                selectedLanguageCode =
                                                    answer.value.toString();
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
                                                color: answer.id.toString() ==
                                                        selectedLanguageId
                                                    ? AppColors.yellow
                                                    : AppColors.white,
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        AppColors.borderColor),
                                              ),
                                              child: Center(
                                                child: TextWidget(
                                                  text: answer.name ?? '',
                                                  textAlign: TextAlign.center,
                                                  fontSize: 14,
                                                  color: answer.id.toString() ==
                                                          selectedLanguageId
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
            itemCount: 9,
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

  Future<void> callUpdateProfileApi() async {
    setState(() {
      isProfileUpdate = true;
    });
    await context.read<UserProvider>().updateProfileApi(
          language: selectedLanguageCode ?? '',
          languageId: selectedLanguageId ?? '',
          context: context,
        );
    setState(() {
      isProfileUpdate = false;
    });
  }
}
