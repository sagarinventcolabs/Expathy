import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Models/benefits_model.dart';
import 'package:expathy/Screens/Checkout%20Screen/checkout_screen.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Utils/app_images.dart';
import '../../Widgets/svg_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlanPackageScreen extends StatefulWidget {
  const PlanPackageScreen({Key? key}) : super(key: key);

  @override
  State<PlanPackageScreen> createState() => _PlanPackageScreenState();
}

class _PlanPackageScreenState extends State<PlanPackageScreen> {
  List<BenefitsModel> benefitsList = [
    BenefitsModel(
      heading: 'Cancel & Reschedule',
      description: 'Cancellation & Rescheduling before 24 hrs',
    ),
    BenefitsModel(
      heading: 'Video Session',
      description: '50 minutes for video session',
    ),
    BenefitsModel(
      heading: 'Video Session',
      description: '50 minutes for video session',
    ),
    BenefitsModel(
      heading: 'Video Session',
      description: '50 minutes for video session',
    ),
  ];

  String dropdownValue = 'EURO';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(
                      deviceWidth(context),
                      (deviceHeight(context) * 0.60)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: AuthScreenPainter(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 22, left: 22),
                  child: Column(
                    children: [
                      //heightGap(20),
                      Row(
                        children: [
                          Expanded(
                            child: ToolBarWidget(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              title: AppLocalizations.of(context)!.packages,
                            ),
                          ),
                          Container(
                            width: deviceWidth(context) * 0.30,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: DropdownButtonFormField(
                              isDense: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.checkBoxBorderColor,
                                      width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.checkBoxBorderColor,
                                      width: 1),
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                              ),
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'EURO',
                                'IND',
                                'USD',
                                'DINAR'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: TextWidget(
                                    text: '€ $value',
                                    fontSize: 14,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      heightGap(12),
                      SizedBox(
                        width: deviceWidth(context) * 0.40,
                        height: deviceHeight(context) * 0.15,
                        child: const SvgPic(
                          image: AppImages.logoMain,
                          fit: BoxFit.contain,
                        ),
                      ),
                      heightGap(10),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                        ),
                        child: TabBar(
                          padding: const EdgeInsets.all(4),
                          indicatorColor: Colors.transparent,
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.greyText,
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w400,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w400,
                          ),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.green,
                          ),
                          tabs: [
                            Tab(
                              text: AppLocalizations.of(context)!.bronze,
                            ),
                            Tab(
                              text: AppLocalizations.of(context)!.gold,
                            ),
                            Tab(
                              text: AppLocalizations.of(context)!.silver,
                            )
                          ],
                        ),
                      ),
                      heightGap(16),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.white,
                          ),
                          child: TabBarView(
                            children: [
                              planItem(
                                  amount: '39.99',
                                  saveAmount: '100',
                                  session: '4'),
                              planItem(
                                  amount: '29.99',
                                  saveAmount: '100',
                                  session: '24'),
                              planItem(
                                  amount: '39.99',
                                  saveAmount: '100',
                                  session: '12'),
                            ],
                          ),
                        ),
                      ),
                      heightGap(90),
                    ],
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                TextWidget(
                                  text: '24 Sessions in 6 months',
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                TextWidget(
                                  text: '€ 719.16',
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButtonWidget(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CheckoutScreen(),
                                ));
                              },
                              text: 'Purchased'),
                        ],
                      ),
                    ),
                  ),
                ),
                /* Positioned(
                  top: 0,
                  right: 10,
                  child: Container(
                    width: deviceWidth(context) * 0.30,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: DropdownButtonFormField(
                      isDense: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.checkBoxBorderColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.checkBoxBorderColor, width: 1),
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                      ),
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['EURO', 'IND', 'USD', 'DINAR']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: TextWidget(
                            text: '€ $value',
                            fontSize: 14,
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget planItem({String? amount, String? session, String? saveAmount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(
                children: [
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    const TextWidget(
                      text: '€',
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.poppins,
                    ),
                    /* TextWidget(
                      text: amount ?? '',
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.poppins,
                    )*/
                    Column(children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 42,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.poppins,
                          ),
                          children: [
                            const TextSpan(
                              text: '29.',
                            ),
                            WidgetSpan(
                              child: Transform.translate(
                                offset: const Offset(0.0, -20.0),
                                child: const Text(
                                  '99',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.poppins,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ]),
                  const TextWidget(
                    text: 'per session',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.poppins,
                  ),
                  heightGap(10),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    const TextWidget(
                      text: 'save',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greenDark,
                      fontFamily: AppFonts.poppins,
                    ),
                    widthGap(5),
                    TextWidget(
                      text: saveAmount ?? '',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greenDark,
                      fontFamily: AppFonts.poppins,
                    )
                  ]),
                  heightGap(5),
                  TextWidget(
                    text: '$session session',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFonts.poppins,
                  ),
                  heightGap(10),
                ],
              ),
            ),
            const TextWidget(
              text: 'Benefits includes:',
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            heightGap(5),
            ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: benefitsList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final benefits = benefitsList[index];
                return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.check,
                          color: AppColors.black,
                          size: 18,
                        )),
                      ),
                      widthGap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: benefits.heading ?? '',
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                            heightGap(2),
                            TextWidget(
                              text: benefits.description ?? '',
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      ),
                    ]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return heightGap(10);
              },
            ),
          ],
        ),
      ),
    );
  }
}
