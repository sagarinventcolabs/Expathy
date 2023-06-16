import 'package:carousel_slider/carousel_slider.dart';
import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Models/benefits_model.dart';
import 'package:expathy/Providers/Subscription%20Provider/subscription_provider.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:expathy/Widgets/underline_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Models/subscription_list_model.dart';
import '../../Utils/navigation_services.dart';
import '../../Widgets/skeleton_widget.dart';
import '../Checkout Screen/checkout_screen.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
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

  late Future<SubscriptionListModel?> subscriptionListFuture;

  @override
  void initState() {
    subscriptionListFuture =
        context.read<SubscriptionProvider>().fetchSubscriptionListApi(
              context: context,
            );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = context.read<SubscriptionProvider>();
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
                      heightGap(24),
                      CustomFutureBuilder<SubscriptionListModel?>(
                        loaderWidget: loadingShimmer(),
                        future: subscriptionListFuture,
                        noInternetOnPressed: () {},
                        data: (snapshot) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: AppLocalizations.of(context)!
                                      .benefitsIncludes,
                                  color: AppColors.white,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                ),
                                ListView.separated(
                                  itemCount: benefitsList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final benefits = benefitsList[index];
                                    return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 26,
                                            height: 26,
                                            decoration: BoxDecoration(
                                              color: AppColors.greenLight,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: const Center(
                                                child: Icon(
                                              Icons.check,
                                              color: AppColors.white,
                                              size: 18,
                                            )),
                                          ),
                                          widthGap(10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(
                                                text: benefits.heading ?? '',
                                                color: AppColors.white,
                                                fontFamily: AppFonts.poppins,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                              ),
                                              heightGap(2),
                                              TextWidget(
                                                text:
                                                    benefits.description ?? '',
                                                color: AppColors.white,
                                                fontFamily: AppFonts.poppins,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                              ),
                                            ],
                                          ),
                                        ]);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return heightGap(10);
                                  },
                                ),
                                heightGap(30),
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 300.0,
                                    enlargeCenterPage: true,
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    viewportFraction: 0.65,
                                    onPageChanged: (index, reason) {
                                      subscriptionProvider.filterPlan(
                                          index: index);
                                    },
                                  ),
                                  items: snapshot?.data?.data?.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                UnderLineText(
                                                  text: i.type ?? '',
                                                  fontSize: 32,
                                                  textColor: AppColors.yellow,
                                                ),
                                                heightGap(20),
                                                Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextWidget(
                                                        text: dropdownValue ==
                                                                'EURO'
                                                            ? '€'
                                                            : dropdownValue ==
                                                                    'IND'
                                                                ? '₹'
                                                                : '\$',
                                                        fontSize: 42,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            AppFonts.poppins,
                                                      ),
                                                      TextWidget(
                                                        text: i.price
                                                                .toString() ??
                                                            '',
                                                        fontSize: 42,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            AppFonts.poppins,
                                                      )
                                                    ]),
                                                TextWidget(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .perSession,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: AppFonts.poppins,
                                                ),
                                                heightGap(20),
                                                Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextWidget(
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .save,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.greenDark,
                                                        fontFamily:
                                                            AppFonts.poppins,
                                                      ),
                                                      widthGap(5),
                                                      const TextWidget(
                                                        text: '€100',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColors.greenDark,
                                                        fontFamily:
                                                            AppFonts.poppins,
                                                      )
                                                    ]),
                                                heightGap(10),
                                                TextWidget(
                                                  text:
                                                      '${i.session ?? ''} session',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: AppFonts.poppins,
                                                ),
                                              ]),
                                        );
                                      },
                                    );
                                  }).toList(),
                                )
                              ]);
                        },
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
                    child: Consumer<SubscriptionProvider>(
                      builder: (context, value, child) {
                        final plan = value.plan;
                        return value.fetchingSubscription
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
                                    text:
                                        AppLocalizations.of(context)!.purchase,
                                  ),
                                ],
                              );
                      },
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

  Widget loadingShimmer() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      shimmerEffect(
        widget: SkeletonWidget(
          height: 20,
          width: deviceWidth(context) * 0.45,
        ),
      ),
      heightGap(20),
      ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: AppColors.greenLight,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(
                  child: Icon(
                Icons.check,
                color: AppColors.white,
                size: 18,
              )),
            ),
            widthGap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  shimmerEffect(
                    widget: SkeletonWidget(
                      height: 18,
                      width: deviceWidth(context) * 0.45,
                    ),
                  ),
                  heightGap(8),
                  shimmerEffect(
                    widget: SkeletonWidget(
                      height: 16,
                      width: deviceWidth(context) * 0.60,
                    ),
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
      heightGap(30),
      CarouselSlider(
        options: CarouselOptions(
          height: 320.0,
          enlargeCenterPage: true,
          scrollPhysics: const BouncingScrollPhysics(),
          viewportFraction: 0.65,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                child: shimmerEffect(
                  widget: const SkeletonWidget(
                    radius: 12.0,
                    width: double.infinity,
                  ),
                ),
              );
            },
          );
        }).toList(),
      )
    ]);
  }
}
