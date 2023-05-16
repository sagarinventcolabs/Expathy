import 'dart:convert';
import 'dart:developer';
import 'package:expathy/Models/common_model.dart';
import 'package:expathy/Models/language_list_model.dart';
import 'package:expathy/Models/questions_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Screens/Therapists Screen/find_therapists_screen.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/app_strings.dart';
import '../../Utils/helper_methods.dart';
import '../../main.dart';

class QuestionProvider with ChangeNotifier {
  LanguageListModel? languageListModel;
  QuestionsListModel? questionListModel;
  List<Map<String, dynamic>> selectedQuestionList = [];

  Future<LanguageListModel?> fetchLanguageListApi(
      {required BuildContext context}) async {
    final data = await RemoteService().callGetApi(
      url: eLanguageList,
    );
    if (data != null) {
      final languageListResponse =
          LanguageListModel.fromJson(jsonDecode(data.body));
      log('api call response : ${languageListResponse.toJson().toString()}');
      if (context.mounted) {
        if (languageListResponse.status == 200) {
          languageListModel = languageListResponse;
        } else if (languageListResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: languageListResponse.message,
              context: context);
        } else if (languageListResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: languageListResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return languageListResponse;
    }
    return null;
  }

  Future<List<Question>?> fetchQuestionsListApi(
      {required BuildContext context}) async {
    final data = await RemoteService().callGetApi(
      url: eQuestionList,
    );
    if (data != null) {
      final questionsListResponse =
          QuestionsListModel.fromJson(jsonDecode(data.body));
      log('api call response : ${questionsListResponse.toJson().toString()}');
      if (context.mounted) {
        if (questionsListResponse.status == 200) {
          questionListModel = questionsListResponse;
        } else if (questionsListResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: questionsListResponse.message,
              context: context);
        } else if (questionsListResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: questionsListResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return questionsListResponse.data?.data;
    }
    return null;
  }

  Future<CommonModel?> submitQuestionAnswerApi(
      {required List<Map<String, dynamic>> selectedQuestionList,
      required BuildContext context}) async {
    final data = await RemoteService()
        .callPostApi(url: eSubmitQuestionAnswer, jsonData: {
      "question": selectedQuestionList,
    });
    if (data != null) {
      final commonResponse = CommonModel.fromJson(jsonDecode(data.body));
      log('api call response : ${commonResponse.toJson().toString()}');
      if (context.mounted) {
        if (commonResponse.status == 200) {
          sharedPrefs?.setBool(AppStrings.isQuestionSubmit, true);
          showSnackBar(
              isSuccess: true,
              message: commonResponse.message,
              context: context);

          showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Lottie.asset(AppImages.warningJson,
                          width: 100, height: 100),
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
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' Please call 113',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.yellow,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                              text: ' Suicide prevention unit !!!',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      heightGap(18),
                      Center(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.yellowLight,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.call,
                                    color: AppColors.yellow,
                                    size: 15,
                                  ),
                                  widthGap(5),
                                  const TextWidget(
                                    text: '113',
                                    fontSize: 14,
                                    color: AppColors.yellow,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  widthGap(10),
                                  InkWell(
                                    onTap: () async {
                                      await Clipboard.setData(
                                              const ClipboardData(text: "113"))
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "copied to clipboard")));
                                      });
                                      // copied successfully
                                    },
                                    child: const Icon(
                                      Icons.copy,
                                      color: AppColors.black,
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
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const FindTherapistsScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          text: 'Ok'),
                    ]),
              );
            },
          );
        } else if (commonResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: commonResponse.message,
              context: context);
        } else if (commonResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: commonResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return commonResponse;
    }
    return null;
  }

  Future<void> addSelectedQuestion() async {
    questionListModel?.data?.data?.forEach((element) {
      if (element.selectedAnswer.isNotEmpty) {
        /*  selectedQuestionList.add(SelectedQuestionModel(
            questionId: element.id.toString(),
            options: element.selectedAnswer));
      }*/
        selectedQuestionList.add({
          "questionId": element.id.toString(),
          "answer": element.selectedAnswer
        });
      }
    });
  }
}
