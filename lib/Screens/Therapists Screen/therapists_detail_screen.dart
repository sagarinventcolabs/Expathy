import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Providers/Psychologists%20Provider/psychologists_provider.dart';
import 'package:expathy/Screens/Articles%20Screen/all_articles_screen.dart';
import 'package:expathy/Screens/Package%20Screen/package_screen.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:expathy/Widgets/underline_text_widget.dart';
import 'package:expathy/Widgets/view_all_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Models/article_model.dart';
import '../../Models/get_psychologist_detail_model.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/article_item.dart';
import '../../Widgets/horzontal_two_button_widget.dart';
import '../../Widgets/info_widget.dart';
import '../../Widgets/skeleton_widget.dart';
import '../Article Screen/article_detail_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TherapistsDetailScreen extends StatefulWidget {
  // final PsychologistList? psychologist;
  final String? psychologistId;
  final bool isFromTherapistListScreen;

  const TherapistsDetailScreen(
      {Key? key, this.psychologistId, this.isFromTherapistListScreen = false})
      : super(key: key);

  @override
  State<TherapistsDetailScreen> createState() => _TherapistsDetailScreenState();
}

class _TherapistsDetailScreenState extends State<TherapistsDetailScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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

  late Future<GetPsychologistDetailApi?> dashboardFuture;

  @override
  void initState() {
    dashboardFuture = context
        .read<PsychologistsProvider>()
        .fetchPsychologistsDetailApi(
            context: context, psychologistId: widget.psychologistId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
          child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightGap(20),
                    ToolBarWidget(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      iconColor: AppColors.white,
                      title: AppLocalizations.of(context)!.therapistDetails,
                      titleColor: AppColors.white,
                    ),
                    heightGap(20),
                    CustomFutureBuilder<GetPsychologistDetailApi?>(
                      loaderWidget: loadingShimmer(),
                      future: dashboardFuture,
                      noInternetOnPressed: () {
                        setState(() {
                          dashboardFuture = context
                              .read<PsychologistsProvider>()
                              .fetchPsychologistsDetailApi(
                                  context: context,
                                  psychologistId:
                                      widget.psychologistId.toString());
                        });
                      },
                      data: (snapshot) {
                        final details = snapshot?.data;
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      InfoWidget(
                                        name: details?.name ?? '',
                                        type: details?.psychologistType?.name ??
                                            '',
                                        description: details?.description ?? '',
                                        imageUrl: details?.profilePic ?? '',
                                        onTap: () {
                                          /* Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const TherapistsDetailScreen(),
                              ));*/
                                        },
                                      ),
                                      heightGap(10),
                                      if (widget.isFromTherapistListScreen)
                                        ElevatedButtonWidget(
                                            onPressed: () {}, text: 'Select'),
                                      if (!widget.isFromTherapistListScreen)
                                        HorizontalTwoButtonWidget(
                                          text1: AppLocalizations.of(context)!
                                              .freeSessionNow,
                                          text1Tap: () {
                                            _bottomSheet(context: context);
                                          },
                                          text2: AppLocalizations.of(context)!
                                              .bookFullSession,
                                          text2Tap: () {
                                            _bottomSheet(
                                                context: context,
                                                navigateToPackageScreen: true);
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              heightGap(16),
                              TextWidget(
                                text: AppLocalizations.of(context)!.biography,
                                fontSize: 18,
                                color: AppColors.white,
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w400,
                              ),
                              heightGap(10),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UnderLineText(
                                        text: AppLocalizations.of(context)!
                                            .areasOfExpertise,
                                      ),
                                      heightGap(10),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            details?.areaOfExperties?.length ??
                                                2,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 4 / 1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemBuilder: (context, index) {
                                          final areaOfExperties =
                                              details?.areaOfExperties?[index];
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
                                                        'Social Psychologist',
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      heightGap(30),
                                      UnderLineText(
                                        text: AppLocalizations.of(context)!
                                            .education,
                                      ),
                                      heightGap(10),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            details?.education?.length ?? 1,
                                        itemBuilder: (context, index) {
                                          final education =
                                              details?.education?[index];
                                          return educationItem(
                                              university: education?.university,
                                              graduationType:
                                                  education?.graduationType);
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const Divider();
                                        },
                                      ),
                                      heightGap(30),
                                      UnderLineText(
                                        text:
                                            AppLocalizations.of(context)!.about,
                                      ),
                                      heightGap(12),
                                      TextWidget(
                                        text: details?.description ??
                                            'Donec vitae mi vulputate, suscipit urna in, malesuada nisl. Pellentesque laoreet pretium nisl, et pulvinar massa eleifend sed. Curabitur maximus mollis diam, vel varius sapien suscipit eget. Cras sollicitudin Read more',
                                        fontSize: 14,
                                        color: AppColors.greyText,
                                        fontFamily: AppFonts.poppins,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              heightGap(24),
                              if (details!.articles!.isNotEmpty)
                                ViewAllRowWidget(
                                    text:
                                        AppLocalizations.of(context)!.articles,
                                    textColor: AppColors.black,
                                    onViewAllPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AllArticlesScreen(
                                                  articleList:
                                                      details.articles),
                                        ),
                                      );
                                    },
                                    viewAllColor: AppColors.blue),
                              if (details.articles!.isNotEmpty) heightGap(8),
                              if (details.articles!.isNotEmpty)
                                SizedBox(
                                  height: 220,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: details.articles?.length,
                                    physics: const BouncingScrollPhysics(),
                                    clipBehavior: Clip.none,
                                    itemBuilder: (context, index) {
                                      final articleData =
                                          details.articles?[index];
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
                )),
          ),
        ),
      )),
    );
  }

  Widget loadingShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Row(children: [
          shimmerEffect(
            widget: SkeletonWidget(
              radius: 0,
              height: 16,
              width: deviceWidth(context) * 0.30,
            ),
          ),
        ]),
        heightGap(10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerEffect(
                  widget: SkeletonWidget(
                    radius: 0,
                    height: 20,
                    width: deviceWidth(context) * 0.45,
                  ),
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
                heightGap(30),
                shimmerEffect(
                  widget: SkeletonWidget(
                    radius: 0,
                    height: 20,
                    width: deviceWidth(context) * 0.35,
                  ),
                ),
                heightGap(10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Row(children: [
                      shimmerEffect(
                        widget: const SkeletonWidget(
                          radius: 0,
                          height: 60,
                          width: 60,
                        ),
                      ),
                      widthGap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            shimmerEffect(
                              widget: const SkeletonWidget(
                                radius: 0,
                                height: 20,
                                width: double.infinity,
                              ),
                            ),
                            heightGap(6),
                            shimmerEffect(
                              widget: const SkeletonWidget(
                                radius: 0,
                                height: 16,
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
                heightGap(30),
                shimmerEffect(
                  widget: SkeletonWidget(
                    radius: 0,
                    height: 20,
                    width: deviceWidth(context) * 0.40,
                  ),
                ),
                heightGap(12),
                shimmerEffect(
                  widget: const SkeletonWidget(
                    radius: 0,
                    height: 10,
                    width: double.infinity,
                  ),
                ),
                heightGap(5),
                shimmerEffect(
                  widget: const SkeletonWidget(
                    radius: 0,
                    height: 10,
                    width: double.infinity,
                  ),
                ),
                heightGap(5),
                shimmerEffect(
                  widget: const SkeletonWidget(
                    radius: 0,
                    height: 10,
                    width: double.infinity,
                  ),
                ),
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

  Widget educationItem({String? university, String? graduationType}) {
    return Row(children: [
      Image.asset(AppImages.education),
      widthGap(10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: university ?? 'Education',
              fontSize: 16,
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w500,
            ),
            heightGap(6),
            TextWidget(
              text: graduationType ?? 'Psychology Undergraduate',
              fontSize: 14,
              color: AppColors.greyText,
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    ]);
  }

  Widget expertiseButton() {
    return Row(children: [
      Expanded(
        child: ElevatedButtonWidget(
            onPressed: () {},
            elevation: 0,
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
            textColor: AppColors.black,
            text: 'Family Conflict',
            primary: AppColors.yellowLight),
      ),
    ]);
  }

  List<String> arr = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  Widget _showDate(DateTime date) {
    return TextWidget(
      text: arr[date.weekday - 1],
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

  Future<void> _bottomSheet(
      {BuildContext? context, bool navigateToPackageScreen = false}) async {
    return await showModalBottomSheet<void>(
      context: context!,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
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
                    TextWidget(
                      text: AppLocalizations.of(context)!.selectTime,
                      fontSize: 20,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w500,
                    ),
                    heightGap(15),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 90,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? AppColors.green
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(44),
                            ),
                            child: Center(
                              child: TextWidget(
                                text: '6.00 PM',
                                fontSize: 13,
                                color: index == 0
                                    ? AppColors.white
                                    : AppColors.black,
                                fontFamily: AppFonts.poppins,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    heightGap(15),
                    ElevatedButtonWidget(
                        onPressed: () {
                          if (navigateToPackageScreen) {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PackageScreen(),
                            ));
                          } else {
                            Navigator.of(context).pop();
                            showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Column(
                                          children: [
                                            Lottie.asset(AppImages.congratsJson,
                                                width: 100, height: 100),
                                            heightGap(5),
                                            TextWidget(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .congrats,
                                              color: AppColors.greenLight,
                                              fontSize: 24,
                                              fontFamily: AppFonts.poppins,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            TextWidget(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .yesYouBookedSuccessfully,
                                              fontFamily: AppFonts.poppins,
                                              fontSize: 18,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ],
                                        ),
                                        heightGap(18),
                                        ElevatedButtonWidget(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          text: AppLocalizations.of(context)!
                                              .goToHome,
                                        ),
                                      ]),
                                );
                              },
                            );
                          }
                        },
                        text: AppLocalizations.of(context)!.bookSession,
                        primary: AppColors.yellow),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
