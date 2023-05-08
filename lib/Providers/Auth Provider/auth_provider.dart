import 'dart:convert';
import 'dart:developer';
import 'package:expathy/Models/common_model.dart';
import 'package:expathy/Models/sign_up_model.dart';
import 'package:expathy/Screens/Auth%20Screens/otp_verify_screen.dart';
import 'package:expathy/Screens/Auth%20Screens/prehome_screen.dart';
import 'package:expathy/Screens/Bottom%20Bar%20Screen/bottom_bar_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/change_password_screen.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Remote/api_config.dart';
import '../../Remote/remote_service.dart';
import '../../Screens/Question Answer Screen/question_answer_screen.dart';

class AuthProvider with ChangeNotifier {
  Future<AuthModel?> signUpApi(
      {String? email,
      String? password,
      String? userName,
      String? type,
      String? loginType,
      required BuildContext context}) async {
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
      if (signUpResponse.status == 201) {
        ///add token,user,email to sharedPreference
        sharedPrefs?.setString(
            AppStrings.token, signUpResponse.data?.token.toString() ?? '');
        sharedPrefs?.setString(AppStrings.userName,
            signUpResponse.data?.user?.userName.toString() ?? '');
        sharedPrefs?.setString(AppStrings.email,
            signUpResponse.data?.user?.email.toString() ?? '');
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuestionAnswerScreen(),
            ),
          );
        }
      } else if (signUpResponse.status == 409) {
        if (context.mounted) {
          showSnackBar(
              isSuccess: false,
              message: signUpResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return signUpResponse;
    }
    return null;
  }

  Future<AuthModel?> loginApi(
      {required String email,
      required String password,
      required String type,
      required BuildContext context}) async {
    final data = await RemoteService().callPostApi(url: eLogin, jsonData: {
      "email": email,
      "password": password,
      "type": type,
    });
    if (data != null) {
      final loginResponse = AuthModel.fromJson(jsonDecode(data.body));
      log('api call response : ${loginResponse.toJson().toString()}');
      if (loginResponse.status == 200) {
        ///add token,user,email to sharedPreference
        sharedPrefs?.setString(
            AppStrings.token, loginResponse.data?.token.toString() ?? '');
        sharedPrefs?.setString(AppStrings.userName,
            loginResponse.data?.user?.userName.toString() ?? '');
        sharedPrefs?.setString(
            AppStrings.email, loginResponse.data?.user?.email.toString() ?? '');
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomBarScreen(),
            ),
          );
        }
      } else if (loginResponse.status == 404) {
        if (context.mounted) {
          showSnackBar(
              isSuccess: false,
              message: loginResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return loginResponse;
    }
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
      if (resetPasswordResponse.status == 200) {
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PreHomeScreen(),
            ),
            (route) => false,
          );
        }
      } else if (resetPasswordResponse.status == 404) {
        if (context.mounted) {
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
    final data = await RemoteService().callPostApi(url: eVerifyOtp, jsonData: {
      "email": email,
      "otp": otp,
    });
    if (data != null) {
      final otpVerifyResponse = CommonModel.fromJson(jsonDecode(data.body));
      log('api call response : ${otpVerifyResponse.toJson().toString()}');
      if (otpVerifyResponse.status == 200) {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChangePasswordScreen(),
            ),
          );
        }
      } else if (otpVerifyResponse.status == 404) {
        if (context.mounted) {
          showSnackBar(
              isSuccess: false,
              message: otpVerifyResponse.message,
              context: context);
        }
      }
      notifyListeners();
      return otpVerifyResponse;
    }
    return null;
  }

  Future<CommonModel?> forgotPasswordApi(
      {required String email, required BuildContext context}) async {
    try {
      final data =
          await RemoteService().callPostApi(url: eForgotPassword, jsonData: {
        "email": email,
      });
      if (data != null) {
        final forgotPasswordResponse =
            CommonModel.fromJson(jsonDecode(data.body));
        log('api call response : ${forgotPasswordResponse.toJson().toString()}');
        if (forgotPasswordResponse.status == 200) {
          if (context.mounted) {
            showSnackBar(
                isSuccess: true,
                message: forgotPasswordResponse.message,
                context: context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OtpVerifyScreen(),
              ),
            );
          }
        } else if (forgotPasswordResponse.status == 404) {
          if (context.mounted) {
            showSnackBar(
                isSuccess: false,
                message: forgotPasswordResponse.message,
                context: context);
          }
        }
        notifyListeners();
        return forgotPasswordResponse;
      }
      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
