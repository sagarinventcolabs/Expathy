import 'dart:developer';

import 'package:expathy/main.dart';
import 'package:flutter/material.dart';

import '../../Utils/app_strings.dart';

class LanguageProvider with ChangeNotifier {
  Locale _appLocale =
      Locale(sharedPrefs?.getString(AppStrings.languageCode) ?? 'en');

  Locale get appLocal => _appLocale;

  void changeLanguage({String? languageCode}) async {
    log(languageCode ?? 'languagecode');
    await sharedPrefs?.setString(AppStrings.languageCode, '$languageCode');
    _appLocale = Locale('$languageCode');
    notifyListeners();
  }
}
