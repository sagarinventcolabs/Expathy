import 'dart:convert';
import 'dart:developer';
import 'package:expathy/Models/common_model.dart';
import 'package:expathy/Models/auth_model.dart';
import 'package:expathy/Screens/Auth%20Screens/otp_verify_screen.dart';
import 'package:expathy/Screens/Auth%20Screens/prehome_screen.dart';
import 'package:expathy/Screens/Bottom%20Bar%20Screen/bottom_bar_screen.dart';
import 'package:expathy/Screens/Question%20Answer%20Screen/first_question_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/change_password_screen.dart';
import 'package:expathy/Screens/Therapists%20Screen/therapists_list_screen.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../Models/personal_information_model.dart';
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Utils/navigation_services.dart';
import '../Language Provider/language_provider.dart';

class AuthProvider with ChangeNotifier {
  String? _email;
  String? _currentAddress;
  Position? _currentPosition;

  String? get getEmail => _email;

  set setEmail(String? email) {
    _email = email;
  }

  bool showLoadingIndicator = false;
  bool passwordObSecureLogin = true;
  bool passwordObSecureSignUp = true;
  bool confirmPasswordObSecureSignup = true;

  Future<AuthModel?> signUpApi(
      {String? email,
      String? password,
      String? userName,
      String? type,
      String? loginType,
      required BuildContext context}) async {
    showLoadingIndicator = true;
    notifyListeners();
    final data = await RemoteService().callPostApi(url: eSignUp, jsonData: {
      "email": email,
      "password": password,
      "userName": userName,
      "type": type,
      "loginType": loginType,
    });
    if (data != null) {
      final signUpResponse = AuthModel.fromJson(jsonDecode(data.body));
      log('api call response : ${signUpResponse.toJson().toString()}');
      if (context.mounted) {
        if (signUpResponse.status == 201) {
          ///add token,user,email,languageCode to sharedPreference
          sharedPrefs?.setString(
              AppStrings.token, signUpResponse.data?.token.toString() ?? '');
          sharedPrefs?.setString(AppStrings.userName,
              signUpResponse.data?.user?.userName.toString() ?? '');
          sharedPrefs?.setString(AppStrings.email,
              signUpResponse.data?.user?.email.toString() ?? '');
          sharedPrefs?.setBool(AppStrings.isLogin, true);
          sharedPrefs?.setBool(AppStrings.isFirstTimeOnApp, false);
          /*sharedPrefs?.setString(AppStrings.languageCode,
              signUpResponse.data?.user?.language.toString() ?? '');*/
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FirstQuestionScreen(),
            ),
          );
          showLoadingIndicator = false;
        } else if (signUpResponse.status == 409) {
          showLoadingIndicator = false;
          showSnackBar(
              isSuccess: false,
              message: signUpResponse.message,
              context: context);
        } else if (signUpResponse.status == 400) {
          showLoadingIndicator = false;
          showSnackBar(
              isSuccess: false,
              message: signUpResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return signUpResponse;
    }
    showLoadingIndicator = false;
    notifyListeners();
    return null;
  }

  Future<AuthModel?> loginApi(
      {required String email,
      required String password,
      required String type,
      required BuildContext context}) async {
    showLoadingIndicator = true;
    notifyListeners();
    final data = await RemoteService().callPostApi(url: eLogin, jsonData: {
      "email": email,
      "password": password,
      "type": type,
    });
    if (data != null) {
      final loginResponse = AuthModel.fromJson(jsonDecode(data.body));
      log('api call response : ${loginResponse.toJson().toString()}');
      if (context.mounted) {
        if (loginResponse.status == 200) {
          ///add token,userName,email,isFirstTimeOnApp,islogin, to sharedPreference
          sharedPrefs?.setString(
              AppStrings.token, loginResponse.data?.token.toString() ?? '');
          sharedPrefs?.setString(AppStrings.userName,
              loginResponse.data?.user?.userName.toString() ?? '');
          sharedPrefs?.setString(AppStrings.email,
              loginResponse.data?.user?.email.toString() ?? '');
          sharedPrefs?.setBool(AppStrings.isFirstTimeOnApp, false);
          sharedPrefs?.setBool(AppStrings.isLogin, true);
          sharedPrefs?.setBool(AppStrings.isQuestionSubmit,
              loginResponse.data?.user?.isQuestionSubmit ?? false);
          sharedPrefs?.setBool(AppStrings.isHaveOneTherapists,
              loginResponse.data?.user?.isHaveTherapists ?? false);
          context.read<LanguageProvider>().changeLanguage(
                languageCode:
                    loginResponse.data?.user?.language.toString() ?? 'en',
              );

          if (loginResponse.data?.user?.isQuestionSubmit != null &&
              loginResponse.data?.user?.isHaveTherapists != null) {
            if (!(loginResponse.data!.user!.isQuestionSubmit!)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FirstQuestionScreen(),
                ),
              );
            } else if (!(loginResponse.data!.user!.isHaveTherapists!)) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TherapistsListScreen(
                      showChangeLanguageDialog: true, showBackButton: false),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomBarScreen(),
                ),
              );
            }
          }
          showLoadingIndicator = false;
        } else if (loginResponse.status == 404) {
          showLoadingIndicator = false;
          showSnackBar(
              isSuccess: false,
              message: loginResponse.message,
              context: context);
        } else if (loginResponse.status == 400) {
          showLoadingIndicator = false;
          showSnackBar(
              isSuccess: false,
              message: loginResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return loginResponse;
    }
    showLoadingIndicator = false;
    notifyListeners();
    return null;
  }

  Future<CommonModel?> resetPasswordApi(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final data =
        await RemoteService().callPostApi(url: eResetPassword, jsonData: {
      "email": email,
      "password": password,
    });
    if (data != null) {
      final resetPasswordResponse = CommonModel.fromJson(jsonDecode(data.body));
      log('api call response : ${resetPasswordResponse.toJson().toString()}');
      if (context.mounted) {
        if (resetPasswordResponse.status == 200) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PreHomeScreen(),
            ),
            (route) => false,
          );
        } else if (resetPasswordResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: resetPasswordResponse.message,
              context: context);
        } else if (resetPasswordResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: resetPasswordResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return resetPasswordResponse;
    }
    return null;
  }

  Future<CommonModel?> verifyOtpApi(
      {required String email,
      required String otp,
      required BuildContext context}) async {
    showLoadingIndicator = true;
    notifyListeners();
    final data = await RemoteService().callPostApi(url: eVerifyOtp, jsonData: {
      "email": email,
      "otp": otp,
    });
    if (data != null) {
      final otpVerifyResponse = CommonModel.fromJson(jsonDecode(data.body));
      log('api call response : ${otpVerifyResponse.toJson().toString()}');
      if (context.mounted) {
        if (otpVerifyResponse.status == 200) {
          NavigationServices.pushReplacement(
            context: context,
            screen: const ChangePasswordScreen(makeSetPassword: true),
          );
          showLoadingIndicator = false;
        } else if (otpVerifyResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: otpVerifyResponse.message,
              context: context);
          showLoadingIndicator = false;
        } else if (otpVerifyResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: otpVerifyResponse.message,
              context: context);
          showLoadingIndicator = false;
        }
      }
      notifyListeners();
      return otpVerifyResponse;
    }
    showLoadingIndicator = false;
    notifyListeners();
    return null;
  }

  Future<CommonModel?> forgotPasswordApi(
      {required String email, required BuildContext context}) async {
    showLoadingIndicator = true;
    notifyListeners();
    final data =
        await RemoteService().callPostApi(url: eForgotPassword, jsonData: {
      "email": email,
    });
    if (data != null) {
      final forgotPasswordResponse =
          CommonModel.fromJson(jsonDecode(data.body));
      log('api call response : ${forgotPasswordResponse.toJson().toString()}');
      if (context.mounted) {
        if (forgotPasswordResponse.status == 200) {
          showSnackBar(
              isSuccess: true,
              message: forgotPasswordResponse.message,
              context: context);
          NavigationServices.push(
              context: context, screen: const OtpVerifyScreen());
          /* Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OtpVerifyScreen(),
            ),
          );*/
          showLoadingIndicator = false;
        } else if (forgotPasswordResponse.status == 404) {
          showLoadingIndicator = false;
          showSnackBar(
              isSuccess: false,
              message: forgotPasswordResponse.message,
              context: context);
        } else if (forgotPasswordResponse.status == 400) {
          showLoadingIndicator = false;
          showSnackBar(
              isSuccess: false,
              message: forgotPasswordResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return forgotPasswordResponse;
    }
    showLoadingIndicator = false;
    notifyListeners();
    return null;
  }

  Future<CommonModel?> changePasswordApi(
      {String? password,
      String? newPassword,
      required BuildContext context}) async {
    final data =
        await RemoteService().callPostApi(url: eChangePassword, jsonData: {
      "password": password,
      "new_password": newPassword,
    });
    if (data != null) {
      final changePasswordResponse =
          CommonModel.fromJson(jsonDecode(data.body));
      log('api call response : ${changePasswordResponse.toJson().toString()}');
      if (context.mounted) {
        if (changePasswordResponse.status == 200) {
          showSnackBar(
              isSuccess: true,
              message: changePasswordResponse.message,
              context: context);
          Navigator.of(context).pop();
        } else if (changePasswordResponse.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: changePasswordResponse.message,
              context: context);
        } else if (changePasswordResponse.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: changePasswordResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return changePasswordResponse;
    }
    return null;
  }

  Future<void> changeObSecureForLogin() async {
    passwordObSecureLogin = !passwordObSecureLogin;
    notifyListeners();
  }

  Future<void> changeObSecureForSignUp({bool forPassword = false}) async {
    if (forPassword) {
      passwordObSecureSignUp = !passwordObSecureSignUp;
    } else {
      confirmPasswordObSecureSignup = !confirmPasswordObSecureSignup;
    }
    notifyListeners();
  }

  Future<PersonalInfo?> getPersonalInfoApi(
      {required BuildContext context,
      required String slug,
      required String type}) async {
    final data = await RemoteService().callGetApi(
      url: '$eGetContent/$slug/$type',
    );
    if (data != null) {
      final personalInfoModel =
          PersonalInformationModel.fromJson(jsonDecode(data.body));
      if (context.mounted) {
        if (personalInfoModel.status == 200) {
        } else if (personalInfoModel.status == 404) {
          showSnackBar(
              isSuccess: false,
              message: personalInfoModel.message,
              context: context);
        } else if (personalInfoModel.status == 400) {
          showSnackBar(
              isSuccess: false,
              message: personalInfoModel.message,
              context: context);
        }
      }
      notifyListeners();
      return personalInfoModel.data;
    }
    return null;
  }

  Future<void> setAddressData(
      {String? address, Position? currentPosition}) async {
    _currentAddress = address;
    _currentPosition = currentPosition;
    notifyListeners();
  }
}
