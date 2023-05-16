import 'dart:developer';
import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Common%20Widgets/text_form_field_widget.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Models/questions_list_model.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Custom Painter /question_screen_custom_painter.dart';
import '../../Providers/Question Provider/question_provider.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/skeleton_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({Key? key}) : super(key: key);

  @override
  State<QuestionAnswerScreen> createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  int questionIndex = 0;
  double barPercentage = 0.1;
  late Future<List<Question>?> questionsListFuture;
  List<Question>? questionList = [];
  Question? questionData;
  String? questionId;
  bool isQuestionsSubmitting = false;

  @override
  void initState() {
    questionsListFuture =
        context.read<QuestionProvider>().fetchQuestionsListApi(
              context: context,
            );
    super.initState();
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
                      if (questionIndex != questionList!.length - 1)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 20, right: 20),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  previousQuestion();
                                  calculatePercentage(
                                      questionIndex: questionIndex,
                                      questionsLength: questionList!.length);
                                },
                                child: questionIndex == 0
                                    ? const SizedBox(
                                        width: 65,
                                      )
                                    : Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: AppColors.white,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back,
                                        ),
                                      ),
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
                                onTap: () {
                                  nextQuestion();
                                  calculatePercentage(
                                      questionIndex: questionIndex,
                                      questionsLength: questionList!.length);
                                },
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
                      if (questionIndex == questionList!.length - 1)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  previousQuestion();
                                  calculatePercentage(
                                      questionIndex: questionIndex,
                                      questionsLength: questionList!.length);
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
                              isQuestionsSubmitting
                                  ? const Center(
                                      child: CupertinoActivityIndicator(
                                          color: AppColors.white),
                                    )
                                  : ElevatedButtonWidget(
                                      onPressed: () async {
                                        context
                                            .read<QuestionProvider>()
                                            .addSelectedQuestion();
                                        await callSubmitQuestionAnswerApi();
                                      },
                                      height: 48,
                                      text: 'Complete',
                                      primary: AppColors.white,
                                      textColor: AppColors.black),
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
                    ToolBarWidget(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    heightGap(14),
                    CustomFutureBuilder<List<Question>?>(
                      loaderWidget: loadingShimmer(),
                      future: questionsListFuture,
                      noInternetOnPressed: () {
                        setState(() {
                          questionsListFuture = context
                              .read<QuestionProvider>()
                              .fetchQuestionsListApi(
                                context: context,
                              );
                        });
                      },
                      data: (snapshot) {
                        questionList = snapshot;
                        questionData = snapshot?[questionIndex];
                        questionId = questionData?.id.toString();
                        log('question id : $questionId');
                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: showHeading() ?? '',
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
                              Center(
                                child: TextWidget(
                                  text: questionData?.question ?? '',
                                  fontSize: 22,
                                  textAlign: TextAlign.center,
                                  color: AppColors.white,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              heightGap(30),
                              if (questionData!.options!.isNotEmpty)
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        ...?questionData?.options!
                                            .map((answer) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  answer.isSelected =
                                                      !answer.isSelected;
                                                });
                                                if (questionData!.selectedAnswer
                                                    .contains(answer.option)) {
                                                  questionData?.selectedAnswer
                                                      .remove(
                                                          answer.option ?? '');
                                                } else {
                                                  questionData?.selectedAnswer
                                                      .add(answer.option ?? '');
                                                }
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
                                                      answer.isSelected == true
                                                          ? AppColors.yellow
                                                          : AppColors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          answer.isSelected ==
                                                                  true
                                                              ? AppColors.black
                                                              : AppColors
                                                                  .borderColor),
                                                ),
                                                child: Center(
                                                  child: TextWidget(
                                                    text: answer.option ?? '',
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14,
                                                    color: answer.isSelected ==
                                                            true
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                    fontFamily:
                                                        AppFonts.poppins,
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
                              if (questionData!.options!.isEmpty)
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: TextFormFieldWidget(
                                    filled: true,
                                    borderRadius: 30,
                                    hintColor: AppColors.black,
                                    fillColor: AppColors.white,
                                    textAlign: TextAlign.center,
                                    hintText: 'Enter your answer',
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
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

  Future<void> callSubmitQuestionAnswerApi({String? therapistsId}) async {
    setState(() {
      isQuestionsSubmitting = true;
    });
    await context.read<QuestionProvider>().submitQuestionAnswerApi(
        selectedQuestionList:
            context.read<QuestionProvider>().selectedQuestionList,
        context: context);
    setState(() {
      isQuestionsSubmitting = false;
    });
  }

  Widget loadingShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightGap(20),
        shimmerEffect(
          widget: const SkeletonWidget(
            radius: 10,
            height: 20,
            width: 150,
          ),
        ),
        heightGap(20),
        shimmerEffect(
          widget: const SkeletonWidget(
            radius: 10,
            height: 10,
            width: double.infinity,
          ),
        ),
        heightGap(20),
        shimmerEffect(
          widget: const SkeletonWidget(
            radius: 0,
            height: 40,
            width: double.infinity,
          ),
        ),
        heightGap(20),
        SizedBox(
          height: 400,
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

  void nextQuestion() {
    if (questionIndex == questionList!.length - 1) {
    } else {
      setState(() {
        questionIndex++;
      });
    }
  }

  String? showHeading() {
    if (questionList!.length >= 4) {
      if (questionIndex == questionList!.length - 1) {
        return AppLocalizations.of(context)!.andWeAreDone;
      } else if (questionIndex == questionList!.length - 2) {
        return AppLocalizations.of(context)!.oneMore;
      } else if (questionIndex == questionList!.length - 3) {
        return AppLocalizations.of(context)!.almostDone;
      } else {
        return AppLocalizations.of(context)!.greatMoving;
      }
    } else {
      if (questionIndex == questionList!.length - 1) {
        return AppLocalizations.of(context)!.andWeAreDone;
      } else {
        return AppLocalizations.of(context)!.greatMoving;
      }
    }
  }

  void previousQuestion() {
    if (questionIndex != 0) {
      setState(() {
        questionIndex--;
      });
    }
  }

  void calculatePercentage(
      {required int questionIndex, required int questionsLength}) {
    final percentage = (questionIndex + 1) / questionsLength;
    setState(() {
      barPercentage = double.parse(percentage.toString());
      log(barPercentage.toString());
    });
  }
}

/*
import 'dart:developer';
import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Common%20Widgets/text_form_field_widget.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Models/questions_list_model.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Custom Painter /question_screen_custom_painter.dart';
import '../../Models/questions_model.dart';
import '../../Providers/Question Provider/question_provider.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../Therapists Screen/find_therapists_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({Key? key}) : super(key: key);

  @override
  State<QuestionAnswerScreen> createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  List<QuestionsModel> questionList = [
    QuestionsModel(
        question: 'What is your native language?',
        heading: 'Let’s Start...',
        answers: [
          AnswerModel(text: 'English', isSelected: false),
          AnswerModel(text: 'Español', isSelected: false),
          AnswerModel(text: 'العربية', isSelected: false),
          AnswerModel(text: 'Polski', isSelected: false),
          AnswerModel(text: 'Turkce', isSelected: false),
          AnswerModel(text: 'Farsi', isSelected: false),
          AnswerModel(text: 'हिन्दी', isSelected: false),
          AnswerModel(text: 'Deutsch', isSelected: false),
          AnswerModel(text: 'Português', isSelected: false),
        ]),
    QuestionsModel(
        question: 'Your social issue is important for us!! Select any of them',
        heading: 'Great Moving...',
        answers: [
          AnswerModel(text: 'Discrimination', isSelected: false),
          AnswerModel(text: 'Difficulty in making friends', isSelected: false),
          AnswerModel(text: 'Feeling homesick', isSelected: false),
          AnswerModel(text: 'Language barrier', isSelected: false),
          AnswerModel(text: 'Cultural differences', isSelected: false),
          AnswerModel(text: 'Other', isSelected: false),
        ]),
    QuestionsModel(
        question: 'Please describe your gender identity',
        heading: 'Great Moving...',
        answers: [
          AnswerModel(text: 'Non-binary', isSelected: false),
          AnswerModel(text: 'Female', isSelected: false),
          AnswerModel(text: 'Male', isSelected: false),
        ]),
    QuestionsModel(
        question: 'Relationship status?',
        heading: 'Great Moving...',
        answers: [
          AnswerModel(text: 'Married', isSelected: false),
          AnswerModel(text: 'Single', isSelected: false),
          AnswerModel(text: 'Divorced', isSelected: false),
          AnswerModel(text: 'Widowed', isSelected: false),
          AnswerModel(text: 'Other', isSelected: false),
        ]),
    QuestionsModel(
        question: 'Rate your current financial status',
        heading: 'Great Moving...',
        answers: [
          AnswerModel(text: 'Good', isSelected: false),
          AnswerModel(text: 'Fair', isSelected: false),
          AnswerModel(text: 'NOT Good', isSelected: false),
        ]),
    QuestionsModel(
        question: 'Any problem with your sleep?',
        heading: 'Almost done...',
        answers: [
          AnswerModel(text: 'Yes', isSelected: false),
          AnswerModel(text: 'No', isSelected: false),
        ]),
    QuestionsModel(
        question: 'Are you taking any medication?',
        heading: 'One more...',
        answers: [
          AnswerModel(text: 'Yes', isSelected: false),
          AnswerModel(text: 'No', isSelected: false),
        ]),
    QuestionsModel(
        question: 'How old are you?',
        heading: 'And we are done...',
        answers: [
          AnswerModel(text: 'Yes', isSelected: false),
          AnswerModel(text: 'No', isSelected: false),
        ]),
  ];
  int questionIndex = 0;
  double barPercentage = 0.0;
  late Future<List<Question>?> questionsListFuture;
  Question? questionData;

  @override
  void initState() {
    calculatePercentage(questionIndex: 0, questionsLength: questionList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questionData = questionList[questionIndex];
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
                      if (questionIndex != questionList.length - 1)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 20, right: 20),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  previousQuestion();
                                  calculatePercentage(
                                      questionIndex: questionIndex,
                                      questionsLength: questionList.length);
                                },
                                child: questionIndex == 0
                                    ? const SizedBox(
                                        width: 65,
                                      )
                                    : Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: AppColors.white,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back,
                                        ),
                                      ),
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
                                onTap: () {
                                  nextQuestion();
                                  calculatePercentage(
                                      questionIndex: questionIndex,
                                      questionsLength: questionList.length);
                                },
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
                      if (questionIndex == questionList.length - 1)
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  previousQuestion();
                                  calculatePercentage(
                                      questionIndex: questionIndex,
                                      questionsLength: questionList.length);
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
                              ElevatedButtonWidget(
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          true, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Lottie.asset(
                                                    AppImages.warningJson,
                                                    width: 100,
                                                    height: 100),
                                                heightGap(5),
                                                const Text.rich(
                                                  textAlign: TextAlign.start,
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'This app is not suitable for people with suicidal tendencies.',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              AppFonts.poppins,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' Please call 113',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .yellow,
                                                            fontFamily: AppFonts
                                                                .poppins,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' Suicide prevention unit !!!',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: AppFonts
                                                                .poppins,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                heightGap(18),
                                                Center(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors
                                                            .yellowLight,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 10),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Icon(
                                                              Icons.call,
                                                              color: AppColors
                                                                  .yellow,
                                                              size: 15,
                                                            ),
                                                            widthGap(5),
                                                            const TextWidget(
                                                              text: '113',
                                                              fontSize: 14,
                                                              color: AppColors
                                                                  .yellow,
                                                              fontFamily:
                                                                  AppFonts
                                                                      .poppins,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            widthGap(10),
                                                            InkWell(
                                                              onTap: () async {
                                                                await Clipboard.setData(
                                                                        const ClipboardData(
                                                                            text:
                                                                                "113"))
                                                                    .then(
                                                                        (value) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text("copied to clipboard")));
                                                                });
                                                                // copied successfully
                                                              },
                                                              child: const Icon(
                                                                Icons.copy,
                                                                color: AppColors
                                                                    .black,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                                heightGap(18),
                                                ElevatedButtonWidget(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const FindTherapistsScreen(),
                                                          ));
                                                    },
                                                    text: 'Ok'),
                                              ]),
                                        );
                                      },
                                    );
                                  },
                                  height: 48,
                                  text: 'Complete',
                                  primary: AppColors.white,
                                  textColor: AppColors.black),
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
                    ToolBarWidget(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    heightGap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: questionData.heading ?? '',
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
                          Center(
                            child: TextWidget(
                              text: questionData.question ?? '',
                              fontSize: 22,
                              textAlign: TextAlign.center,
                              color: AppColors.white,
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          heightGap(30),
                          if (questionIndex != questionList.length - 1)
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    ...?questionData.answers?.map((answer) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              answer.isSelected =
                                                  !answer.isSelected!;
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
                                              color: answer.isSelected == true
                                                  ? AppColors.yellow
                                                  : AppColors.white,
                                              border: Border.all(
                                                  width: 1,
                                                  color: answer.isSelected ==
                                                          true
                                                      ? AppColors.black
                                                      : AppColors.borderColor),
                                            ),
                                            child: Center(
                                              child: TextWidget(
                                                text: answer.text ?? '',
                                                textAlign: TextAlign.center,
                                                fontSize: 14,
                                                color: answer.isSelected == true
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
                          if (questionIndex == questionList.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormFieldWidget(
                                filled: true,
                                borderRadius: 30,
                                hintColor: AppColors.black,
                                fillColor: AppColors.white,
                                textAlign: TextAlign.center,
                                hintText: 'Enter your answer',
                              ),
                            ),
                        ],
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

  void nextQuestion() {
    if (questionIndex == questionList!.length - 1) {
    } else {
      setState(() {
        questionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (questionIndex != 0) {
      setState(() {
        questionIndex--;
      });
    }
  }

  void calculatePercentage(
      {required int questionIndex, required int questionsLength}) {
    final percentage = (questionIndex + 1) / questionsLength;
    setState(() {
      barPercentage = double.parse(percentage.toString());
      log(barPercentage.toString());
    });
  }
}
*/
