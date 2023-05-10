import 'dart:convert';
import 'dart:developer';

import 'package:expathy/Models/update_profile_model.dart';
import 'package:expathy/Providers/Language%20Provider/language_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Screens/Question Answer Screen/question_answer_screen.dart';
import '../../Utils/app_strings.dart';
import '../../Utils/helper_methods.dart';
import '../../main.dart';

class UserProvider with ChangeNotifier {
  Future<UpdateProfileModel?> updateProfileApi(
      {required String language,
      required String languageId,
      required BuildContext context}) async {
    final data =
        await RemoteService().callPostApi(url: eUpdateProfile, jsonData: {
      "language": language,
      "languageId": languageId,
    });
    if (data != null) {
      final updateProfileResponse =
          UpdateProfileModel.fromJson(jsonDecode(data.body));
      log('api call response : ${updateProfileResponse.toJson().toString()}');
      if (context.mounted) {
        if (updateProfileResponse.status == 200) {
          showSnackBar(
              isSuccess: true,
              message: updateProfileResponse.message,
              context: context);
          context.read<LanguageProvider>().changeLanguage(
                languageCode: updateProfileResponse.data?.language.toString(),
              );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuestionAnswerScreen(),
            ),
          );
        } else if (updateProfileResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: updateProfileResponse.message,
              context: context);
        } else if (updateProfileResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: updateProfileResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return updateProfileResponse;
    }
    return null;
  }
}
