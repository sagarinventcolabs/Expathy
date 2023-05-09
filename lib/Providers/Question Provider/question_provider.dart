import 'dart:convert';
import 'dart:developer';
import 'package:expathy/Models/first_question_model.dart';
import 'package:flutter/material.dart';
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Utils/app_strings.dart';
import '../../Utils/helper_methods.dart';
import '../../main.dart';

class QuestionProvider with ChangeNotifier {
  FirstQuestionModel? firstQuestionModel;

  Future<FirstQuestionModel?> fetchFirstQuestionApi(
      {required BuildContext context}) async {
    final data = await RemoteService().callGetApi(url: eFirstQuestion);
    if (data != null) {
      final firstQuestionResponse =
          FirstQuestionModel.fromJson(jsonDecode(data.body));
      log('api call response : ${firstQuestionResponse.toJson().toString()}');
      if (context.mounted) {
        if (firstQuestionResponse.status == 200) {
          firstQuestionModel = firstQuestionResponse;
        } else if (firstQuestionResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: firstQuestionResponse.message,
              context: context);
        } else if (firstQuestionResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: firstQuestionResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return firstQuestionResponse;
    }
    return null;
  }

  Future<FirstQuestionModel?> fetchQuestionsListApi(
      {required BuildContext context}) async {
    final data = await RemoteService().callGetApi(url: eQuestionList);
    if (data != null) {
      final questionListResponse =
          FirstQuestionModel.fromJson(jsonDecode(data.body));
      log('api call response : ${questionListResponse.toJson().toString()}');
      if (context.mounted) {
        if (questionListResponse.status == 200) {
        } else if (questionListResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: questionListResponse.message,
              context: context);
        } else if (questionListResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: questionListResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return questionListResponse;
    }
    return null;
  }
}
