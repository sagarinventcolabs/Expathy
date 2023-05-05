import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Screens/Bottom%20Bar%20Screen/bottom_bar_screen.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/main.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Custom Painter /question_screen_custom_painter.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomPaint(
                        size: Size(
                            deviceWidth(context),
                            (deviceHeight(context) * 0.30)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: QuestionScreenCustomPainter(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.logo,
                            height: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: deviceHeight(context) * 0.70,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    heightGap(30),
                    const TextWidget(
                      text: 'Payment Successful!',
                      fontSize: 32,
                      textAlign: TextAlign.center,
                      color: AppColors.greenDark,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w500,
                    ),
                    heightGap(10),
                    const TextWidget(
                      text: 'Order ID : #1234567890',
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w400,
                    ),
                    heightGap(20),
                    ElevatedButtonWidget(
                        onPressed: () {},
                        text: 'Go to Orders',
                        textColor: AppColors.black,
                        forGroundColor: AppColors.green,
                        primary: AppColors.white,
                        showBorder: true),
                    heightGap(20),
                    ElevatedButtonWidget(
                        onPressed: () {
                          sharedPrefs?.setBool(AppStrings.isFreePlan, false);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const BottomBarScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        text: 'Go to Home'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
