import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:expathy/Models/common_model.dart';
import 'package:expathy/Models/update_profile_model.dart';
import 'package:expathy/Providers/Language%20Provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/dashboard_model.dart';
import '../../Models/get_profile_model.dart';
import '../../Models/image_upload_model.dart';
import '../../Models/notification_model.dart';
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Screens/Bottom Bar Screen/bottom_bar_screen.dart';
import '../../Screens/Question Answer Screen/question_answer_screen.dart';
import '../../Utils/app_strings.dart';
import '../../Utils/helper_methods.dart';
import '../../main.dart';

class UserProvider with ChangeNotifier {
  bool showLoadingIndicator = false;
  bool dashboardFetching = false;
  DashboardModel? dashboardData;
  bool profileLoading = false;
  GetProfileModel? profileData;
  bool profileImageUploading = false;
  String? profileImageUrl;
  List<NotificationDoc>? notificationList;

  Future<UpdateProfileModel?> updateProfileApi(
      {String? language,
      String? languageId,
      String? userName,
      String? therapistsId,
      String? profilePic,
      String? age,
      bool isFromSelectTherapistScreen = false,
      bool isFromChangeLanguageScreen = false,
      bool isFromEditProfileScreen = false,
      required BuildContext context}) async {
    final data =
        await RemoteService().callPostApi(url: eUpdateProfile, jsonData: {
      "language": language,
      "appLanguage": language,
      "languageId": languageId,
      "appLanguageId": languageId,
      "name": userName,
      "therapists": therapistsId,
      "profilePic": profilePic,
      "age": age,
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
          sharedPrefs?.setString(AppStrings.userName,
              updateProfileResponse.data?.userName.toString() ?? '');
          sharedPrefs?.setString(AppStrings.email,
              updateProfileResponse.data?.email.toString() ?? '');
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
          } else if (isFromChangeLanguageScreen) {
            Navigator.of(context).pop();
          } else if (isFromEditProfileScreen) {
            Navigator.of(context).pop();
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
          logOut(context: context);
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

  Future<DashboardModel?> dashboardApi(
      {required BuildContext context,
      String? lat,
      String? long,
      String? address}) async {
    dashboardFetching = true;
    final data = await RemoteService().callGetApi(
      url: '$eDashboard?latitude=26&longitude=25&address=bjhhvvvvvv',
    );
    if (data != null) {
      final dashboardResponse = DashboardModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (dashboardResponse.status == 200) {
          dashboardData = dashboardResponse;
          showSnackBar(message: dashboardResponse.statusText, context: context);
        } else if (dashboardResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: dashboardResponse.statusText,
              context: context);
        } else if (dashboardResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: dashboardResponse.statusText,
              context: context);
        }
      }
      dashboardFetching = false;
      notifyListeners();
      return dashboardResponse;
    }
    dashboardFetching = false;
    notifyListeners();
    return null;
  }

  Future<ImageUploadModel?> imageUploadApi(
      {required BuildContext context, required File file}) async {
    profileImageUploading = true;
    notifyListeners();
    final data = await RemoteService().callMultipartApi(
      url: eImageUpload,
      requestBody: {},
      file: file,
      fileParamName: 'image',
    );
    if (data != null) {
      final imageUploadResponse =
          ImageUploadModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (imageUploadResponse.status == 200) {
          profileImageUrl = imageUploadResponse.data?.upload;
        } else if (imageUploadResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: imageUploadResponse.message,
              context: context);
        } else if (imageUploadResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: imageUploadResponse.message,
              context: context);
        }
      }
      profileImageUploading = false;
      notifyListeners();
      return imageUploadResponse;
    }
    profileImageUploading = false;
    notifyListeners();
    return null;
  }

  Future<GetProfileModel?> getProfileApi(
      {required BuildContext context}) async {
    profileLoading = true;
    final data = await RemoteService().callGetApi(
      url: eGetProfile,
    );
    if (data != null) {
      final getProfileModel = GetProfileModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (getProfileModel.status == 200) {
          profileData = getProfileModel;
          profileImageUrl = getProfileModel.data?.profilePic;
        } else if (getProfileModel.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: getProfileModel.message,
              context: context);
        } else if (getProfileModel.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: getProfileModel.message,
              context: context);
        }
      }
      profileLoading = false;
      notifyListeners();
      return getProfileModel;
    }
    profileLoading = false;
    notifyListeners();
    return null;
  }

  Future<List<NotificationDoc>?> notificationListApi(
      {required BuildContext context,
      required int limit,
      required int pageNumber}) async {
    final data = await RemoteService().callGetApi(
      url: '$eNotificationGet?limit=$limit&page=$pageNumber',
    );
    if (data != null) {
      final notificationResponse =
          NotificationModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (notificationResponse.status == 200) {
          notificationList = notificationResponse.data?.docs;
        } else if (notificationResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: notificationResponse.message,
              context: context);
        } else if (notificationResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: notificationResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return notificationResponse.data?.docs;
    }
    return null;
  }

  Future<CommonModel?> readNotificationApi({
    required BuildContext context,
    required String notificationId,
    required int index,
  }) async {
    final data = await RemoteService().callPutApi(
      url: '$eReadNotification?notificationId=$notificationId',
    );
    if (data != null) {
      final readNotificationResponse =
          CommonModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (readNotificationResponse.status == 200) {
          notificationList?[index].isRead = true;
        } else if (readNotificationResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: readNotificationResponse.message,
              context: context);
        } else if (readNotificationResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: readNotificationResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return readNotificationResponse;
    }
    return null;
  }

  Future<CommonModel?> deleteNotificationApi({
    required BuildContext context,
    required String notificationId,
    required int index,
  }) async {
    final data = await RemoteService().callDeleteApi(
      url: '$eDeleteNotification?notificationId=$notificationId',
    );
    if (data != null) {
      final readNotificationResponse =
          CommonModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (readNotificationResponse.status == 200) {
          notificationList?.removeAt(index);
        } else if (readNotificationResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: readNotificationResponse.message,
              context: context);
        } else if (readNotificationResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: readNotificationResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return readNotificationResponse;
    }
    return null;
  }
}
