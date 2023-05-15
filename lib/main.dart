import 'package:expathy/Providers/app_provider.dart';
import 'package:expathy/Screens/Question%20Answer%20Screen/question_answer_screen.dart';
import 'package:expathy/Screens/Splash/splash_screen.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'Providers/Language Provider/language_provider.dart';

SharedPreferences? sharedPrefs;
GlobalKey<NavigatorState>? navigatorKey;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  sharedPrefs = await SharedPreferences.getInstance();
  navigatorKey = GlobalKey<NavigatorState>();
  await checkDeviceOs();
  runApp(
      MultiProvider(providers: AppProvider.appProviders, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>(
      create: (context) => LanguageProvider(),
      child: Consumer<LanguageProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Expathy',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: value.appLocal,
            supportedLocales: L10n.all,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
