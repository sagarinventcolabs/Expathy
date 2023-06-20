import 'dart:developer';

import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Providers/Auth%20Provider/auth_provider.dart';
import 'package:expathy/Providers/Session%20Provider/session_provider.dart';
import 'package:expathy/Providers/User%20Provider/user_provider.dart';
import 'package:expathy/Screens/Article%20Screen/article_detail_screen.dart';
import 'package:expathy/Screens/Articles%20Screen/all_articles_screen.dart';
import 'package:expathy/Screens/Bottom%20Bar%20Screen/bottom_bar_screen.dart';
import 'package:expathy/Screens/Package%20Screen/package_screen.dart';
import 'package:expathy/Screens/Package%20Screen/plan_package_screen.dart';
import 'package:expathy/Screens/Question%20Answer%20Screen/first_question_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/invite_friends_screen.dart';
import 'package:expathy/Screens/Therapists%20Screen/therapists_list_screen.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/horzontal_two_button_widget.dart';
import 'package:expathy/Widgets/info_widget.dart';
import 'package:expathy/Widgets/svg_picture.dart';
import 'package:expathy/Widgets/upcoming_session_item.dart';
import 'package:expathy/Widgets/view_all_row_widget.dart';
import 'package:expathy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Models/article_model.dart';
import '../../Models/dashboard_model.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/navigation_services.dart';
import '../../Widgets/active_plan_item.dart';
import '../../Widgets/article_item.dart';
import '../../Widgets/skeleton_widget.dart';
import '../Therapists Screen/therapists_detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool showDropDown = false;
  bool showChangeTherapistsOption = false;
  String dropdownValue = 'reason1';
  String? day;
  String? slotTimeFrom, slotTimeTo;

  List<ArticleModel> articleList = [
    ArticleModel(
      image: AppImages.ar5,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
    ArticleModel(
      image: AppImages.ar2,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
    ArticleModel(
      image: AppImages.ar3,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
    ArticleModel(
      image: AppImages.ar4,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
    ArticleModel(
      image: AppImages.ar1,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
  ];

  late Future<DashboardModel?> dashboardFuture;

  @override
  void initState() {
    // context.read<UserProvider>().dashboardApi(context: context);
    dashboardFuture =
        context.read<UserProvider>().dashboardApi(context: context);

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final hasPermission = await _handleLocationPermission();
    if (hasPermission) {
      await _getCurrentPosition();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 0.0),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: deviceWidth(context) * 0.40,
                              height: deviceHeight(context) * 0.15,
                              child: const SvgPic(
                                image: AppImages.logoMain,
                                fit: BoxFit.contain,
                              ),
                            ),
                            heightGap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text:
                                      '${sharedPrefs?.getString(AppStrings.userName) ?? ''}, ',
                                  textAlign: TextAlign.center,
                                  fontSize: 22,
                                  color: AppColors.white,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w600,
                                ),
                                Flexible(
                                  child: TextWidget(
                                    text: AppLocalizations.of(context)!
                                        .weAreHereForYou,
                                    textAlign: TextAlign.center,
                                    fontSize: 22,
                                    color: AppColors.white,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      heightGap(24),
                      CustomFutureBuilder<DashboardModel?>(
                        loaderWidget: loadingShimmer(),
                        future: dashboardFuture,
                        noInternetOnPressed: () {
                          setState(() {
                            dashboardFuture = context
                                .read<UserProvider>()
                                .dashboardApi(context: context);
                          });
                        },
                        data: (snapshot) {
                          final dashboardData = snapshot?.data;
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text:
                                      AppLocalizations.of(context)!.activePlan,
                                  fontSize: 18,
                                  color: AppColors.white,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w400,
                                ),
                                heightGap(8),
                                ActivePlanItem(
                                    isFreePlan:
                                        dashboardData?.isSubscription ?? false,
                                    subscription: dashboardData?.subscription),
                                heightGap(24),

                                ///therapist
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        text: AppLocalizations.of(context)!
                                            .yourTherapist,
                                        fontSize: 18,
                                        color: AppColors.white,
                                        fontFamily: AppFonts.poppins,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          sharedPrefs?.getString("planType") !=
                                              "Gold",
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        const TextWidget(
                                                          text:
                                                              'Changing Your Therapist',
                                                          fontSize: 20,
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontFamily:
                                                              AppFonts.poppins,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        heightGap(10),
                                                        const TextWidget(
                                                          text:
                                                              'You are changing your therapist. Do you want to answer your onboarding questions again?',
                                                          fontSize: 16,
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontFamily:
                                                              AppFonts.poppins,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    heightGap(18),
                                                    ElevatedButtonWidget(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();

                                                          showDialog<void>(
                                                            context: context,
                                                            barrierDismissible:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                ),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    const Column(
                                                                      children: [
                                                                        TextWidget(
                                                                          text:
                                                                              'You will be matched with a new therapist based on your most recent answers to the questions. are you sure?',
                                                                          fontSize:
                                                                              14,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          fontFamily:
                                                                              AppFonts.poppins,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    heightGap(
                                                                        18),
                                                                    HorizontalTwoButtonWidget(
                                                                      text1: AppLocalizations.of(
                                                                              context)!
                                                                          .no,
                                                                      text1Tap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      text2: AppLocalizations.of(
                                                                              context)!
                                                                          .yes,
                                                                      text2Tap:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        NavigationServices.pushAndRemoveUntil(
                                                                            context: context,
                                                                            screen: const TherapistsListScreen(
                                                                              showBackButton: false,
                                                                            ));
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        text:
                                                            'Proceed with Previous Answers'),
                                                    heightGap(8),
                                                    ElevatedButtonWidget(
                                                        onPressed: () {
                                                          NavigationServices
                                                              .pushAndRemoveUntil(
                                                                  context:
                                                                      context,
                                                                  screen:
                                                                      const FirstQuestionScreen());
                                                        },
                                                        text:
                                                            'Answer Questions Again'),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const SvgPic(
                                            image: AppImages.reload),
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              width: 1, color: AppColors.white),
                                        ),
                                        label: TextWidget(
                                          text: AppLocalizations.of(context)!
                                              .change,
                                          fontSize: 14,
                                          color: AppColors.white,
                                          fontFamily: AppFonts.poppins,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                heightGap(15),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 18,
                                    ),
                                    child: Column(
                                      children: [
                                        InfoWidget(
                                          imageUrl: dashboardData
                                              ?.therapists?.profilePic,
                                          name:
                                              dashboardData?.therapists?.name ??
                                                  '',
                                          type:
                                              dashboardData?.therapists?.type ??
                                                  '',
                                          description: dashboardData
                                                  ?.therapists?.description ??
                                              '',
                                          onTap: () {
                                            NavigationServices.push(
                                                context: context,
                                                screen: TherapistsDetailScreen(
                                                    psychologistId:
                                                        dashboardData
                                                            ?.therapists?.sId));
                                          },
                                        ),
                                        heightGap(10),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: ((dashboardData
                                                          ?.therapists
                                                          ?.areaOfExperties
                                                          ?.length ??
                                                      0) >
                                                  2)
                                              ? 2
                                              : dashboardData?.therapists
                                                  ?.areaOfExperties?.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 4 / 1,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10),
                                          itemBuilder: (context, index) {
                                            final areaOfExperties =
                                                dashboardData?.therapists
                                                    ?.areaOfExperties?[index];
                                            return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: AppColors.yellowLight),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Center(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: TextWidget(
                                                      text: areaOfExperties
                                                              ?.name ??
                                                          '',
                                                      fontFamily:
                                                          AppFonts.poppins,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        heightGap(10),
                                        HorizontalTwoButtonWidget(
                                          text1: AppLocalizations.of(context)!
                                              .freeSessionNow,
                                          text1Tap: () {
                                            _bottomSheet(
                                                context: context, type: 'free');
                                          },
                                          text2: AppLocalizations.of(context)!
                                              .bookFullSession,
                                          text2Tap: () {
                                            _bottomSheet(
                                                context: context,
                                                navigateToPackageScreen: true,
                                                type: 'paid');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                heightGap(24),
                                if (dashboardData?.upcoming?.isNotEmpty ??
                                    false)
                                  Column(children: [
                                    ViewAllRowWidget(
                                      text: AppLocalizations.of(context)!
                                          .upcomingSessions,
                                    ),
                                    heightGap(8),
                                    SizedBox(
                                      height: 145,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            dashboardData?.upcoming?.length,
                                        clipBehavior: Clip.none,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final upcomingSession =
                                              dashboardData?.upcoming?[index];
                                          return UpComingSessionItem(
                                            cancelPressed: () {
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    true, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    content: StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Lottie.asset(
                                                                    AppImages
                                                                        .warningJson,
                                                                    width: 100,
                                                                    height:
                                                                        100),
                                                                heightGap(5),
                                                                TextWidget(
                                                                  text: AppLocalizations.of(
                                                                          context)!
                                                                      .areYouSureToCancelTheSession,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      AppFonts
                                                                          .poppins,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ],
                                                            ),
                                                            heightGap(18),
                                                            HorizontalTwoButtonWidget(
                                                              text1: AppLocalizations
                                                                      .of(context)!
                                                                  .no,
                                                              text1Tap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              text2: AppLocalizations
                                                                      .of(context)!
                                                                  .yes,
                                                              text2Tap: () {
                                                                setState(() {
                                                                  showDropDown =
                                                                      true;
                                                                });
                                                              },
                                                            ),
                                                            heightGap(18),
                                                            const Divider(
                                                              color: AppColors
                                                                  .checkBoxBorderColor,
                                                              height: 2,
                                                              indent: 10,
                                                              endIndent: 10,
                                                            ),
                                                            if (showDropDown)
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    heightGap(
                                                                        18),
                                                                    TextWidget(
                                                                      text: AppLocalizations.of(
                                                                              context)!
                                                                          .selectReason,
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          AppFonts
                                                                              .poppins,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    const TextWidget(
                                                                      text:
                                                                          'Donec vitae mi vulputate, suscipit urna in, malesuada nisl. Pellentesque laoreet pretium nisl, et pulvinar massa.',
                                                                      fontSize:
                                                                          12,
                                                                      color: AppColors
                                                                          .greyText,
                                                                      fontFamily:
                                                                          AppFonts
                                                                              .poppins,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    heightGap(
                                                                        18),
                                                                    DropdownButtonFormField(
                                                                      isDense:
                                                                          true,
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down,
                                                                        color: AppColors
                                                                            .checkBoxBorderColor,
                                                                      ),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          borderSide: const BorderSide(
                                                                              color: AppColors.checkBoxBorderColor,
                                                                              width: 1),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          borderSide: const BorderSide(
                                                                              color: AppColors.checkBoxBorderColor,
                                                                              width: 1),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            AppColors.borderColor,
                                                                      ),
                                                                      value:
                                                                          dropdownValue,
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          dropdownValue =
                                                                              newValue!;
                                                                          showChangeTherapistsOption =
                                                                              true;
                                                                        });
                                                                      },
                                                                      items: <String>[
                                                                        'reason1',
                                                                        'reason2',
                                                                        'reason3',
                                                                        'reason4'
                                                                      ].map<
                                                                          DropdownMenuItem<
                                                                              String>>((String
                                                                          value) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              value,
                                                                          child:
                                                                              TextWidget(
                                                                            text:
                                                                                value,
                                                                            fontSize:
                                                                                14,
                                                                            fontFamily:
                                                                                AppFonts.poppins,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                    ),
                                                                  ]),
                                                            if (showChangeTherapistsOption)
                                                              Column(children: [
                                                                const Divider(
                                                                  color: AppColors
                                                                      .checkBoxBorderColor,
                                                                  height: 2,
                                                                  indent: 10,
                                                                  endIndent: 10,
                                                                ),
                                                                heightGap(18),
                                                                const TextWidget(
                                                                  text:
                                                                      'Do you want to change your therapist?',
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      AppFonts
                                                                          .poppins,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                heightGap(18),
                                                                HorizontalTwoButtonWidget(
                                                                  text1: AppLocalizations.of(
                                                                          context)!
                                                                      .no,
                                                                  text1Tap:
                                                                      () {},
                                                                  text2: AppLocalizations.of(
                                                                          context)!
                                                                      .yes,
                                                                  text2Tap:
                                                                      () {},
                                                                ),
                                                              ]),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            postponePressed: () {
                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    true, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Lottie.asset(
                                                                  AppImages
                                                                      .worryJson,
                                                                  width: 100,
                                                                  height: 100),
                                                              heightGap(5),
                                                              const TextWidget(
                                                                text:
                                                                    'No worries,',
                                                                color: AppColors
                                                                    .greenLight,
                                                                fontSize: 24,
                                                                fontFamily:
                                                                    AppFonts
                                                                        .poppins,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              const TextWidget(
                                                                text:
                                                                    'just select another timeslot',
                                                                fontFamily:
                                                                    AppFonts
                                                                        .poppins,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ],
                                                          ),
                                                          heightGap(18),
                                                          ElevatedButtonWidget(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                _bottomSheet(
                                                                    context:
                                                                        context,
                                                                    showBookAgainText:
                                                                        true);
                                                              },
                                                              text: 'Select'),
                                                        ]),
                                                  );
                                                },
                                              );
                                            },
                                            upcoming: upcomingSession,
                                          );
                                        },
                                      ),
                                    ),
                                    heightGap(24),
                                  ]),
                                if (dashboardData!.articles!.isNotEmpty)
                                  ViewAllRowWidget(
                                      text: AppLocalizations.of(context)!
                                          .articles,
                                      onViewAllPressed: () {
                                        NavigationServices.push(
                                            context: context,
                                            screen: AllArticlesScreen(
                                              articleList:
                                                  dashboardData.articles,
                                            ));
                                      },
                                      viewAllColor: AppColors.blue),
                                if (dashboardData.articles!.isNotEmpty)
                                  heightGap(8),
                                if (dashboardData.articles!.isNotEmpty)
                                  SizedBox(
                                    height: 220,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: dashboardData.articles?.length,
                                      physics: const BouncingScrollPhysics(),
                                      clipBehavior: Clip.none,
                                      itemBuilder: (context, index) {
                                        final articleData =
                                            dashboardData.articles?[index];
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleDetailScreen(
                                                        article: articleData),
                                              ),
                                            );
                                          },
                                          /*  child: Container(
                                width: deviceWidth(context) * 0.70,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        topLeft: Radius.circular(12),
                                      ),
                                      child: SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: Image.asset(
                                          articleData.image ?? '',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                            bottom: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: TextWidget(
                                                text: articleData.description ??
                                                    '',
                                                fontSize: 16,
                                                maxLines: 3,
                                                color: AppColors.black,
                                                overflow: TextOverflow.ellipsis,
                                                fontFamily: AppFonts.poppins,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            heightGap(10),
                                            TextWidget(
                                              text: articleData.date ?? '',
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColors.greyText,
                                              fontFamily: AppFonts.poppins,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),*/
                                          child: ArticleItem(
                                              articleData: articleData),
                                        );
                                      },
                                    ),
                                  ),
                                heightGap(10),
                              ]);
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 50,
                    left: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            NavigationServices.push(
                                context: context, screen: const InviteScreen());
                          },
                          child: const SvgPic(
                            image: AppImages.personPlus,
                            color: AppColors.white,
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SvgPic(
                          image: AppImages.notificationIcon,
                          color: AppColors.white,
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _bottomSheet({
    BuildContext? context,
    bool showBookAgainText = false,
    String? type,
    bool navigateToPackageScreen = false,
  }) async {
    return await showModalBottomSheet<void>(
      context: context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext c, StateSetter setState) {
          return Padding(
            padding: MediaQuery.of(c).viewInsets,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 130,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                    TableCalendar(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarStyle: const CalendarStyle(
                        defaultTextStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.poppins,
                          fontSize: 18,
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        headerMargin: EdgeInsets.only(left: 0),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFonts.poppins,
                          fontSize: 13,
                        ),
                        weekendStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFonts.poppins,
                          fontSize: 13,
                        ),
                      ),
                      calendarBuilders: CalendarBuilders(
                        dowBuilder: (context, day) {
                          return Container();
                        },
                        defaultBuilder: (context, day, focusedDay) {
                          return Container();
                        },
                        selectedBuilder: (context, day, focusedDay) {
                          return Container();
                        },
                        markerBuilder: (context, date, events) {
                          return InkWell(
                            onTap: () {
                              context.read<SessionProvider>().getSlotListApi(
                                  context: context,
                                  day: arr[date.weekday - 1].day ?? '');

                              day = arr[date.weekday - 1].day ?? '';

                              setState(() {
                                _selectedDay = date;
                                _focusedDay = date;
                              });
                            },
                            child: Container(
                              width: 70,
                              height: 80,
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: _selectedDay == date
                                    ? AppColors.green
                                    : AppColors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Column(
                                  children: [
                                    _showWeek(date),
                                    Expanded(
                                      child: _showDate(date),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        }
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {}
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    heightGap(15),
                    Consumer<SessionProvider>(
                      builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            (value.getSlotData == null ||
                                    value.getSlotData!.data!.data!.isEmpty)
                                ? const SizedBox()
                                : TextWidget(
                                    text: AppLocalizations.of(context)!
                                        .selectTime,
                                    fontSize: 20,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w500,
                                  ),
                            heightGap(15),
                            value.gettingSlots
                                ? const Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : (value.getSlotData == null ||
                                        value.getSlotData!.data!.data!.isEmpty)
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          itemCount: type == 'free'
                                              ? (value.getSlotData?.data
                                                  ?.data?[0].freeSlots?.length)
                                              : (value.getSlotData?.data
                                                  ?.data?[0].paidSlots?.length),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final slots = type == 'free'
                                                ? (value
                                                    .getSlotData
                                                    ?.data
                                                    ?.data?[0]
                                                    .freeSlots?[index])
                                                : (value
                                                    .getSlotData
                                                    ?.data
                                                    ?.data?[0]
                                                    .paidSlots?[index]);
                                            return InkWell(
                                              onTap: () {
                                                value.setIndex(index: index);
                                                slotTimeFrom = slots?.from;
                                                slotTimeTo = slots?.to;
                                              },
                                              child: Container(
                                                width: 90,
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: BoxDecoration(
                                                  color: index == value.index
                                                      ? AppColors.green
                                                      : AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(44),
                                                ),
                                                child: Center(
                                                  child: TextWidget(
                                                    text:
                                                        '${convert24HourTo12Hour(time: slots?.from ?? '')}-${convert24HourTo12Hour(time: slots?.to ?? '')}',
                                                    fontSize: 13,
                                                    color: index == value.index
                                                        ? AppColors.white
                                                        : AppColors.black,
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                            heightGap(15),
                            value.bookingSession
                                ? const Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : ElevatedButtonWidget(
                                    onPressed: () {
                                      if (showBookAgainText) {
                                        Navigator.of(context).pop();
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible: true,
                                          // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Lottie.asset(
                                                            AppImages
                                                                .congratsJson,
                                                            width: 100,
                                                            height: 100),
                                                        heightGap(5),
                                                        TextWidget(
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .congrats,
                                                          color: AppColors
                                                              .greenLight,
                                                          fontSize: 24,
                                                          fontFamily:
                                                              AppFonts.poppins,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        const TextWidget(
                                                          text:
                                                              'your new appointment is at 5.30 PM',
                                                          fontFamily:
                                                              AppFonts.poppins,
                                                          fontSize: 18,
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ],
                                                    ),
                                                    heightGap(18),
                                                    ElevatedButtonWidget(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      text: AppLocalizations.of(
                                                              context)!
                                                          .goToHome,
                                                    ),
                                                  ]),
                                            );
                                          },
                                        );
                                      } else if (navigateToPackageScreen) {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const PackageScreen(),
                                        ));
                                      } else {
                                        context
                                            .read<SessionProvider>()
                                            .bookSessionApi(
                                                context: context,
                                                date: getDateFormatted(
                                                    data: _selectedDay
                                                        .toString()),
                                                time: slotTimeFrom ?? '',
                                                day: day ?? '',
                                                to: slotTimeTo ?? "",
                                                type: type == 'free'
                                                    ? 'Free'
                                                    : 'Paid')
                                            .then((value) {
                                          if (value?.status == 200) {
                                            Navigator.of(context).pop();
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible: true,
                                              // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Lottie.asset(
                                                                AppImages
                                                                    .congratsJson,
                                                                width: 100,
                                                                height: 100),
                                                            heightGap(5),
                                                            TextWidget(
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .congrats,
                                                              color: AppColors
                                                                  .greenLight,
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  AppFonts
                                                                      .poppins,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            TextWidget(
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .yesYouBookedSuccessfully,
                                                              fontFamily:
                                                                  AppFonts
                                                                      .poppins,
                                                              fontSize: 18,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ],
                                                        ),
                                                        heightGap(18),
                                                        ElevatedButtonWidget(
                                                          onPressed: () {
                                                            NavigationServices
                                                                .pushAndRemoveUntil(
                                                                    context:
                                                                        context,
                                                                    screen:
                                                                        const BottomBarScreen());
                                                          },
                                                          text: AppLocalizations
                                                                  .of(context)!
                                                              .goToHome,
                                                        ),
                                                      ]),
                                                );
                                              },
                                            );
                                          }
                                        });
                                      }
                                    },
                                    text: showBookAgainText
                                        ? 'Book Again'
                                        : AppLocalizations.of(context)!
                                            .bookSession,
                                    primary: AppColors.yellow),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  //List<String> arr = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  List<DayModel> arr = [
    DayModel(
      day: 'monday',
      nickName: 'Mon',
    ),
    DayModel(
      day: 'tuesday',
      nickName: 'Tue',
    ),
    DayModel(
      day: 'wednesday',
      nickName: 'Wed',
    ),
    DayModel(
      day: 'thursday',
      nickName: 'Thu',
    ),
    DayModel(
      day: 'friday',
      nickName: 'Fri',
    ),
    DayModel(
      day: 'saturday',
      nickName: 'Sat',
    ),
    DayModel(
      day: 'sunday',
      nickName: 'Sun',
    ),
  ];

  Widget _showDate(DateTime date) {
    return TextWidget(
      // text: arr[date.weekday - 1],
      text: arr[date.weekday - 1].nickName ?? '',
      fontSize: 13,
      color: _selectedDay == date ? AppColors.white : AppColors.black,
      fontFamily: AppFonts.poppins,
      fontWeight: FontWeight.w400,
    );
  }

  Widget _showWeek(DateTime date) {
    return TextWidget(
      text: '${date.day}',
      fontSize: 16,
      color: _selectedDay == date ? AppColors.white : AppColors.black,
      fontFamily: AppFonts.poppins,
      fontWeight: FontWeight.w500,
    );
  }

  Widget expertiseButton() {
    return Row(children: [
      Expanded(
        child: ElevatedButtonWidget(
            onPressed: () {},
            elevation: 0,
            height: 40,
            borderRadius: 30,
            fontSize: 13,
            textColor: AppColors.black,
            text: 'Family Conflict',
            primary: AppColors.yellowLight),
      ),
      widthGap(10),
      Expanded(
        child: ElevatedButtonWidget(
            onPressed: () {},
            elevation: 0,
            borderRadius: 30,
            fontSize: 13,
            height: 40,
            textColor: AppColors.black,
            text: 'Family Conflict',
            primary: AppColors.yellowLight),
      ),
    ]);
  }

  Widget loadingShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerEffect(
          widget: SkeletonWidget(
            radius: 0,
            height: 16,
            width: deviceWidth(context) * 0.30,
          ),
        ),
        heightGap(10),
        Container(
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
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmerEffect(
                            widget: SkeletonWidget(
                              radius: 0,
                              height: 16,
                              width: deviceWidth(context) * 0.20,
                            ),
                          ),
                          shimmerEffect(
                            widget: SkeletonWidget(
                              radius: 0,
                              height: 16,
                              width: deviceWidth(context) * 0.20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    shimmerEffect(
                      widget: SkeletonWidget(
                        radius: 0,
                        height: 45,
                        width: deviceWidth(context) * 0.25,
                      ),
                    ),
                  ],
                ),
                const Divider(color: AppColors.checkBoxBorderColor),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          shimmerEffect(
                            widget: SkeletonWidget(
                              radius: 0,
                              height: 10,
                              width: deviceWidth(context) * 0.25,
                            ),
                          ),
                          heightGap(10),
                          shimmerEffect(
                            widget: SkeletonWidget(
                              radius: 0,
                              height: 15,
                              width: deviceWidth(context) * 0.10,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          shimmerEffect(
                            widget: SkeletonWidget(
                              radius: 0,
                              height: 10,
                              width: deviceWidth(context) * 0.25,
                            ),
                          ),
                          heightGap(10),
                          shimmerEffect(
                            widget: SkeletonWidget(
                              radius: 0,
                              height: 15,
                              width: deviceWidth(context) * 0.10,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          shimmerEffect(
                            widget: SkeletonWidget(
                              radius: 0,
                              height: 10,
                              width: deviceWidth(context) * 0.25,
                            ),
                          ),
                          heightGap(10),
                          shimmerEffect(
                            widget: SkeletonWidget(
                              radius: 0,
                              height: 15,
                              width: deviceWidth(context) * 0.10,
                            ),
                          ),
                        ],
                      ),
                    ]),
              ],
            ),
          ),
        ),
        heightGap(20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          shimmerEffect(
            widget: SkeletonWidget(
              radius: 0,
              height: 16,
              width: deviceWidth(context) * 0.30,
            ),
          ),
          shimmerEffect(
            widget: SkeletonWidget(
              radius: 0,
              height: 30,
              width: deviceWidth(context) * 0.25,
            ),
          ),
        ]),
        heightGap(10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 18,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    shimmerEffect(
                      widget: const SkeletonWidget(
                        radius: 100,
                        height: 75,
                        width: 75,
                      ),
                    ),
                    widthGap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmerEffect(
                            widget: const SkeletonWidget(
                              radius: 0,
                              height: 15,
                            ),
                          ),
                          heightGap(5),
                          shimmerEffect(
                            widget: const SkeletonWidget(
                              radius: 0,
                              height: 10,
                            ),
                          ),
                          heightGap(5),
                          shimmerEffect(
                            widget: const SkeletonWidget(
                              radius: 0,
                              height: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                heightGap(10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return shimmerEffect(
                      widget: const SkeletonWidget(
                        radius: 30,
                      ),
                    );
                  },
                ),
                heightGap(10),
                Row(children: [
                  Expanded(
                    child: shimmerEffect(
                      widget: const SkeletonWidget(
                        radius: 0,
                        height: 45,
                      ),
                    ),
                  ),
                  widthGap(20),
                  Expanded(
                    child: shimmerEffect(
                      widget: const SkeletonWidget(
                        radius: 0,
                        height: 45,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
        heightGap(10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          shimmerEffect(
            widget: SkeletonWidget(
              radius: 0,
              height: 16,
              width: deviceWidth(context) * 0.30,
            ),
          ),
          shimmerEffect(
            widget: SkeletonWidget(
              radius: 0,
              height: 16,
              width: deviceWidth(context) * 0.30,
            ),
          ),
        ]),
        heightGap(10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              return Container(
                width: deviceWidth(context) * 0.55,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    shimmerEffect(
                      widget: const SkeletonWidget(
                        radius: 8,
                        height: 120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heightGap(10),
                          shimmerEffect(
                            widget: const SkeletonWidget(
                              radius: 0,
                              height: 10,
                            ),
                          ),
                          heightGap(5),
                          shimmerEffect(
                            widget: const SkeletonWidget(
                              radius: 0,
                              height: 10,
                            ),
                          ),
                          heightGap(5),
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
                              height: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /* ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));*/
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      /* ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));*/
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _getAddressFromLatLng(position: position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng({Position? position}) async {
    await placemarkFromCoordinates(position!.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        context.read<AuthProvider>().setAddressData(
            address:
                '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}',
            currentPosition: position);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}

class DayModel {
  final String? day;
  final String? nickName;

  DayModel({this.day, this.nickName});
}
