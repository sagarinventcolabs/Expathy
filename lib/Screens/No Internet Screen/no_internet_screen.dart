import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Screens/Question%20Answer%20Screen/first_question_screen.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_colors.dart';

class NoInternetScreen extends StatefulWidget {
  final String screenName;
  const NoInternetScreen({Key? key, required this.screenName})
      : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(
              text: 'No internet',
              color: AppColors.white,
              fontSize: 22,
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w500,
            ),
            ElevatedButtonWidget(
                onPressed: () {
                  if (widget.screenName == 'FirstQuestionScreen') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstQuestionScreen(),
                      ),
                    );
                  }
                },
                text: 'Try Again'),
          ],
        ),
      )),
    );
  }
}
