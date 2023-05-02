import 'package:expathy/Screens/Bottom%20Bar%20Screen/bottom_bar_screen.dart';
import 'package:expathy/Screens/Payment%20Screen/payment_successful_screen.dart';
import 'package:expathy/Screens/Splash/splash_screen.dart';
import 'package:expathy/Screens/Walkthrough%20Screens/tutorial_screen.dart';
import 'package:expathy/Screens/Walkthrough%20Screens/walkthrough_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expathy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TutorialScreen(),
    );
  }
}
