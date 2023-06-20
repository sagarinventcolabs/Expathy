import 'package:expathy/Screens/Package%20Screen/package_screen.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Utils/navigation_services.dart';
import 'package:flutter/material.dart';
import '../Common Widgets/elevated_button_widget.dart';
import '../Common Widgets/text_widget.dart';
import '../Models/dashboard_model.dart';
import '../Models/subscription_list_model.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActivePlanItem extends StatefulWidget {
  final bool isFreePlan;
  final Subscription? subscription;

  const ActivePlanItem({Key? key, this.isFreePlan = true, this.subscription})
      : super(key: key);

  @override
  State<ActivePlanItem> createState() => _ActivePlanItemState();
}

class _ActivePlanItemState extends State<ActivePlanItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isFreePlan == false)
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Free Plan',
                          textAlign: TextAlign.center,
                          fontSize: 18,
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                        ),
                        TextWidget(
                          text: '(20 min./session)',
                          textAlign: TextAlign.center,
                          fontSize: 12,
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                if (widget.isFreePlan)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.yellow,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Icon(Icons.star,
                                    color: AppColors.white, size: 16),
                              ),
                            ),
                            widthGap(5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: widget.subscription?.type ?? '',
                                    textAlign: TextAlign.center,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const FittedBox(
                                    fit: BoxFit.contain,
                                    child: TextWidget(
                                      text: '(60 min./session)',
                                      textAlign: TextAlign.center,
                                      fontSize: 12,
                                      fontFamily: AppFonts.poppins,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // widthGap(5),
                          ],
                        ),
                        const TextWidget(
                          text: 'Valid until 24 May 2023',
                          textAlign: TextAlign.center,
                          fontSize: 14,
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                widthGap(10),
                ElevatedButtonWidget(
                  onPressed: () {
                    NavigationServices.push(
                        context: context, screen: const PackageScreen());
                  },
                  primary: AppColors.yellow,
                  text: AppLocalizations.of(context)!.upgrade,
                ),
              ],
            ),
            const Divider(color: AppColors.checkBoxBorderColor),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              planItem(
                  heading: AppLocalizations.of(context)!.totalSessions,
                  value: '02'),
              planItem(
                  heading: AppLocalizations.of(context)!.completed,
                  value: '02'),
              planItem(
                  heading: AppLocalizations.of(context)!.remaining,
                  value: '02'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget planItem({String? heading, String? value}) {
    return Column(
      children: [
        TextWidget(
          text: heading ?? '',
          textAlign: TextAlign.center,
          fontSize: 13,
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w400,
        ),
        TextWidget(
          text: value ?? '',
          textAlign: TextAlign.center,
          fontSize: 16,
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
