import 'package:dotted_border/dotted_border.dart';
import 'package:expathy/Screens/Payment%20Screen/payment_successful_screen.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/toolbar_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ToolBarWidget(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            title: 'Checkout',
                          ),
                        ],
                      ),
                      heightGap(24),
                      const TextWidget(
                        text: 'Plan Summary',
                        color: AppColors.white,
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        TextWidget(
                                          text: 'Gold Plan',
                                          fontFamily: AppFonts.poppins,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 26,
                                        ),
                                        TextWidget(
                                          text: 'Your plan includes',
                                          fontFamily: AppFonts.poppins,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.yellow),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(children: const [
                                        TextWidget(
                                          text: '50 min',
                                          fontFamily: AppFonts.poppins,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        TextWidget(
                                          text: 'per session',
                                          fontFamily: AppFonts.poppins,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                  color: AppColors.checkBoxBorderColor),
                              rowItem(title: '50 min per session'),
                              rowItem(title: '24 sessions for 3 months'),
                              rowItem(title: 'Expires on 14 June 2023'),
                              rowItem(
                                  title:
                                      'Cancellation & Rescheduling before 24 hrs'),
                            ],
                          ),
                        ),
                      ),
                      heightGap(24),
                      const TextWidget(
                        text: 'Payment Summary',
                        color: AppColors.white,
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      heightGap(24),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        dashPattern: const [6, 6],
                        strokeWidth: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                              color: AppColors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                summeryItem(
                                  title: 'Plan Price',
                                  value: '€ 696',
                                  valueWeight: FontWeight.w500,
                                ),
                                heightGap(20),
                                summeryItem(
                                    title: 'Discount',
                                    value: '-€ 96',
                                    valueWeight: FontWeight.w500,
                                    valueColor: AppColors.greenDark),
                                heightGap(20),
                                const Divider(),
                                heightGap(20),
                                summeryItem(
                                    title: 'Total Amount',
                                    value: '€ 600',
                                    valueSize: 24,
                                    valueWeight: FontWeight.w600,
                                    titleWeight: FontWeight.w600,
                                    titleSize: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButtonWidget(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentSuccessfulScreen(),
                                  ));
                                },
                                text: 'Pay Now')),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowItem({String? title}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: AppColors.yellow),
        width: 8,
        height: 8,
      ),
      widthGap(10),
      Expanded(
        child: TextWidget(
          text: title ?? '',
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    ]);
  }

  Widget summeryItem(
      {String? title,
      String? value,
      Color valueColor = AppColors.black,
      double valueSize = 16,
      double titleSize = 16,
      FontWeight titleWeight = FontWeight.w400,
      FontWeight valueWeight = FontWeight.w400}) {
    return Row(
      children: [
        Expanded(
          child: TextWidget(
            text: title ?? '',
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w400,
            fontSize: titleSize,
          ),
        ),
        TextWidget(
          text: value ?? '',
          fontFamily: AppFonts.poppins,
          color: valueColor,
          fontWeight: FontWeight.w500,
          fontSize: valueSize,
        ),
      ],
    );
  }
}
