import 'package:expathy/main.dart';
import 'package:flutter/material.dart';

import '../../Utils/app_strings.dart';

class LanguageProvider with ChangeNotifier {
  Locale _appLocale =
      Locale(sharedPrefs?.getString(AppStrings.languageCode) ?? 'en');

  Locale get appLocal => _appLocale;

  void toArabic() async {
    await sharedPrefs?.setString(AppStrings.languageCode, 'ar');
    _appLocale = Locale('ar');
    notifyListeners();
  }

  void toEnglish() async {
    await sharedPrefs?.setString(AppStrings.languageCode, 'en');
    _appLocale = Locale('en');
    notifyListeners();
  }

  void toHindi() async {
    await sharedPrefs?.setString(AppStrings.languageCode, 'hi');
    _appLocale = Locale('hi');
    notifyListeners();
  }

  void changeLanguage({String? languageCode}) {
    if (languageCode == 'ar') {
      toArabic();
    } else if (languageCode == 'hi') {
      toHindi();
    } else {
      toEnglish();
    }
    notifyListeners();
  }
/*  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");

  fetchLocale() async {
    if (sharedPrefs?.getString(AppStrings.languageCode) == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(sharedPrefs?.getString(AppStrings.languageCode) ?? 'en');
    return Null;
  }


  void changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }*/
}
