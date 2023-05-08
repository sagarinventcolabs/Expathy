import 'package:expathy/Providers/app_provider.dart';
import 'package:expathy/Screens/Auth%20Screens/forgot_password_screen.dart';
import 'package:expathy/Screens/Auth%20Screens/otp_verify_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/change_password_screen.dart';
import 'package:expathy/Screens/Splash/splash_screen.dart';
import 'package:expathy/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

SharedPreferences? sharedPrefs;
GlobalKey<NavigatorState>? navigatorKey;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  sharedPrefs = await SharedPreferences.getInstance();
  navigatorKey = GlobalKey<NavigatorState>();
  runApp(
      MultiProvider(providers: AppProvider.appProviders, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Expathy',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: L10n.all,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
