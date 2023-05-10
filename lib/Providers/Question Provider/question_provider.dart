import 'dart:convert';
import 'dart:developer';
import 'package:expathy/Models/first_question_model.dart';
import 'package:expathy/Models/questions_list_model.dart';
import 'package:flutter/material.dart';
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Utils/app_strings.dart';
import '../../Utils/helper_methods.dart';
import '../../main.dart';

class QuestionProvider with ChangeNotifier {
  LanguageListModel? languageListModel;
  QuestionsListModel? questionListModel;

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
}
