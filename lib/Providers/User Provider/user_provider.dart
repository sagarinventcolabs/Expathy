import 'dart:convert';
import 'dart:developer';
import 'package:expathy/Models/common_model.dart';
import 'package:expathy/Models/update_profile_model.dart';
import 'package:expathy/Providers/Language%20Provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Screens/Bottom Bar Screen/bottom_bar_screen.dart';
import '../../Screens/Question Answer Screen/question_answer_screen.dart';
import '../../Utils/app_strings.dart';
import '../../Utils/helper_methods.dart';
import '../../main.dart';

class UserProvider with ChangeNotifier {
  bool showLoadingIndicator = false;

  Future<UpdateProfileModel?> updateProfileApi(
      {String? language,
      String? languageId,
      String? therapistsId,
      bool isFromSelectTherapistScreen = false,
      required BuildContext context}) async {
    final data =
        await RemoteService().callPostApi(url: eUpdateProfile, jsonData: {
      "language": language,
      "languageId": languageId,
      "therapists": therapistsId,
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

          if (isFromSelectTherapistScreen) {
            sharedPrefs?.setBool(AppStrings.isHaveOneTherapists, true);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const BottomBarScreen(),
              ),
              (route) => false,
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuestionAnswerScreen(),
              ),
            );
          }
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

  Future<CommonModel?> deleteAccountApi({required BuildContext context}) async {
    showLoadingIndicator = true;
    notifyListeners();
    final data = await RemoteService().callGetApi(
      url: eDeleteAccount,
    );
    if (data != null) {
      final deleteAccountResponse = CommonModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (deleteAccountResponse.status == 200) {
          showLoadingIndicator = false;
          Navigator.of(context).pop();
          showSnackBar(
              isSuccess: false,
              message: deleteAccountResponse.message,
              context: context);
        } else if (deleteAccountResponse.status == 404) {
          showLoadingIndicator = false;
          Navigator.of(context).pop();
          showSnackBar(
              isSuccess: false,
              message: deleteAccountResponse.message,
              context: context);
        } else if (deleteAccountResponse.status == 400) {
          showLoadingIndicator = false;
          Navigator.of(context).pop();
          showSnackBar(
              isSuccess: false,
              message: deleteAccountResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return deleteAccountResponse;
    }
    showLoadingIndicator = false;
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    notifyListeners();
    return null;
  }
}
