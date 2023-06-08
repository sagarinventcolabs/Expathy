import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Models/benefits_model.dart';
import 'package:expathy/Providers/Subscription%20Provider/subscription_provider.dart';
import 'package:expathy/Screens/Checkout%20Screen/checkout_screen.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Utils/navigation_services.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Utils/app_images.dart';
import '../../Widgets/skeleton_widget.dart';
import '../../Widgets/svg_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlanPackageScreen extends StatefulWidget {
  const PlanPackageScreen({Key? key}) : super(key: key);

  @override
  State<PlanPackageScreen> createState() => _PlanPackageScreenState();
}

class _PlanPackageScreenState extends State<PlanPackageScreen>
    with SingleTickerProviderStateMixin {
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
  TabController? tabController;

  @override
  void initState() {
    context
        .read<SubscriptionProvider>()
        .fetchSubscriptionListApi(context: context);
    tabController = TabController(length: 3, vsync: this);
    tabController?.addListener(_getActiveTabIndex);
    super.initState();
  }

  void _getActiveTabIndex() {
    context
        .read<SubscriptionProvider>()
        .filterPlan(index: tabController?.index ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = context.read<SubscriptionProvider>();
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
                  size: Size(deviceWidth(context),
                      (deviceHeight(context) * 0.60).toDouble()),
                  //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
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
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: TextWidget(
                                    text:
                                        '${value == 'EURO' ? '€' : value == 'IND' ? '₹' : '\$'} $value',
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
                      Consumer<SubscriptionProvider>(
                        builder: (context, value, child) {
                          return Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.white,
                            ),
                            child: TabBar(
                              controller: tabController,
                              padding: const EdgeInsets.all(4),
                              indicatorColor: Colors.transparent,
                              labelColor: AppColors.white,
                              unselectedLabelColor: AppColors.greyText,
                              onTap: (value) {
                                subscriptionProvider.filterPlan(index: value);
                              },
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
                                color: value.fetchingSubscription
                                    ? AppColors.white
                                    : AppColors.green,
                              ),
                              tabs: [
                                value.fetchingSubscription
                                    ? shimmerEffect(
                                        widget: const SkeletonWidget(
                                        radius: 12,
                                        height: 48,
                                        width: double.infinity,
                                      ))
                                    : Tab(
                                        text: AppLocalizations.of(context)!
                                            .bronze,
                                      ),
                                value.fetchingSubscription
                                    ? shimmerEffect(
                                        widget: const SkeletonWidget(
                                        radius: 12,
                                        height: 48,
                                        width: double.infinity,
                                      ))
                                    : Tab(
                                        text:
                                            AppLocalizations.of(context)!.gold,
                                      ),
                                value.fetchingSubscription
                                    ? shimmerEffect(
                                        widget: const SkeletonWidget(
                                        radius: 12,
                                        height: 48,
                                        width: double.infinity,
                                      ))
                                    : Tab(
                                        text: AppLocalizations.of(context)!
                                            .silver,
                                      )
                              ],
                            ),
                          );
                        },
                      ),

                      heightGap(16),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.white,
                          ),
                          child: Consumer<SubscriptionProvider>(
                            builder: (context, value, child) {
                              final plan = value.plan;
                              return value.fetchingSubscription
                                  ? loadingShimmer()
                                  : TabBarView(
                                      controller: tabController,
                                      children: [
                                        planItem(
                                          amount: plan?.price.toString(),
                                          saveAmount: '100',
                                          session: plan?.session.toString(),
                                        ),
                                        planItem(
                                          amount: plan?.price.toString(),
                                          saveAmount: '100',
                                          session: plan?.session.toString(),
                                        ),
                                        planItem(
                                          amount: plan?.price.toString(),
                                          saveAmount: '100',
                                          session: plan?.session.toString(),
                                        ),
                                      ],
                                    );
                            },
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
                  child: Consumer<SubscriptionProvider>(
                    builder: (context, value, child) {
                      final plan = value.plan;
                      return Container(
                        decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: value.fetchingSubscription
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          shimmerEffect(
                                            widget: const SkeletonWidget(
                                              radius: 0,
                                              height: 10,
                                            ),
                                          ),
                                          heightGap(10),
                                          shimmerEffect(
                                            widget: const SkeletonWidget(
                                              radius: 0,
                                              height: 20,
                                              width: 60,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    widthGap(20),
                                    Expanded(
                                      child: shimmerEffect(
                                        widget: const SkeletonWidget(
                                          radius: 8,
                                          height: 48,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text:
                                                '${plan?.session ?? ''} Sessions in 1 months',
                                            fontFamily: AppFonts.poppins,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                          TextWidget(
                                            text:
                                                '${dropdownValue == 'EURO' ? '€' : dropdownValue == 'IND' ? '₹' : '\$'} ${plan?.totalPrice ?? ''}',
                                            fontFamily: AppFonts.poppins,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButtonWidget(
                                        onPressed: () {
                                          NavigationServices.push(
                                              context: context,
                                              screen: const CheckoutScreen());
                                        },
                                        text: 'Purchased'),
                                  ],
                                ),
                        ),
                      );
                    },
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
                    TextWidget(
                      text: dropdownValue == 'EURO'
                          ? '€'
                          : dropdownValue == 'IND'
                              ? '₹'
                              : '\$',
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.poppins,
                    ),
                    TextWidget(
                      text: amount ?? '',
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.poppins,
                    )
                    /*  Column(children: [
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
                    ]),*/
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

  Widget loadingShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return shimmerEffect(
            widget: const SkeletonWidget(
              radius: 8,
              height: 60,
              width: double.infinity,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return heightGap(10);
        },
      ),
    );
  }
}
