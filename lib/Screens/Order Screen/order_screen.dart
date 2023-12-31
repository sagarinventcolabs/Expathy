import 'package:expathy/Models/get_session_model.dart';
import 'package:expathy/Providers/Session%20Provider/session_provider.dart';
import 'package:expathy/Screens/Bottom%20Bar%20Screen/bottom_bar_screen.dart';
import 'package:expathy/Screens/Package%20Screen/package_screen.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/skeleton_widget.dart';
import 'package:expathy/Widgets/upcoming_order_item.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/toolbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int tabBarIndex = 0;
  late Future<List<Session>?> sessionListFuture;

  //("Completed ,Cancelled,Upcoming")

  @override
  void initState() {
    sessionListFuture = context.read<SessionProvider>().getSessionListApi(
        type: tabBarIndex == 0
            ? 'Upcoming'
            : tabBarIndex == 1
                ? 'Completed'
                : 'Cancelled',
        context: context);
    tabController = TabController(length: 3, vsync: this);
    tabController?.addListener(_getSessionList);
    super.initState();
  }

  void _getSessionList() {
    setState(() {
      sessionListFuture = context.read<SessionProvider>().getSessionListApi(
          type: tabController?.index == 0
              ? 'Upcoming'
              : tabController?.index == 1
                  ? 'Completed'
                  : 'Cancelled',
          context: context);
    });
  }

  @override
  void dispose() {
    tabController?.dispose();
    tabController?.removeListener(_getSessionList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
        body: GradientBackgroundWidget(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 16, left: 16),
                  child: ToolBarWidget(
                    onTap: () {},
                    showArrowIcon: false,
                    title: AppLocalizations.of(context)!.orders,
                  ),
                ),
                heightGap(24),
                SizedBox(
                  height: 55,
                  child: AppBar(
                    backgroundColor: AppColors.white,
                    bottom: TabBar(
                      controller: tabController,
                      onTap: (value) {
                        setState(() {
                          if (value == 0) {
                            sessionListFuture = context
                                .read<SessionProvider>()
                                .getSessionListApi(
                                    type: 'Upcoming', context: context);
                          } else if (value == 1) {
                            sessionListFuture = context
                                .read<SessionProvider>()
                                .getSessionListApi(
                                    type: 'Completed', context: context);
                          } else {
                            sessionListFuture = context
                                .read<SessionProvider>()
                                .getSessionListApi(
                                    type: 'Cancelled', context: context);
                          }
                        });
                      },
                      labelColor: AppColors.yellow,
                      unselectedLabelColor: AppColors.black,
                      indicatorColor: AppColors.yellow,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 4,
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.upcoming,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.completed,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.cancelled,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 16, left: 16),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        CustomFutureBuilder<List<Session>?>(
                          loaderWidget: loadingShimmer(),
                          future: sessionListFuture,
                          noInternetOnPressed: () {},
                          data: (snapshot) {
                            final sessionList = snapshot;

                            if (sessionList!.isEmpty) {
                              return noData(
                                  title: 'No Upcoming Session',
                                  context: context);
                            } else {
                              return UpcomingOrderItem(
                                data: sessionList,
                                cancelPressed: () {},
                                postponePressed: () {
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
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Column(
                                                children: [
                                                  Lottie.asset(
                                                      AppImages.worryJson,
                                                      width: 100,
                                                      height: 100),
                                                  heightGap(5),
                                                  const TextWidget(
                                                    text: 'No worries,',
                                                    color: AppColors.greenLight,
                                                    fontSize: 24,
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  const TextWidget(
                                                    text:
                                                        'just select another timeslot',
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                              heightGap(18),
                                              ElevatedButtonWidget(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _bottomSheet(
                                                        context: context,
                                                        showBookAgainText:
                                                            true);
                                                  },
                                                  text: 'Select'),
                                            ]),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                        CustomFutureBuilder<List<Session>?>(
                          loaderWidget: loadingShimmer(),
                          future: sessionListFuture,
                          noInternetOnPressed: () {},
                          data: (snapshot) {
                            final sessionList = snapshot;
                            if (sessionList!.isEmpty) {
                              return noData(
                                  title: 'No Completed Session',
                                  context: context);
                            } else {
                              return UpcomingOrderItem(
                                data: sessionList,
                                showRebookButton: true,
                                rebookPressed: () {
                                  _bottomSheet(
                                      context: context,
                                      showBookAgainText: true);
                                },
                              );
                            }
                          },
                        ),
                        CustomFutureBuilder<List<Session>?>(
                          loaderWidget: loadingShimmer(),
                          future: sessionListFuture,
                          noInternetOnPressed: () {},
                          data: (snapshot) {
                            final sessionList = snapshot;
                            if (sessionList!.isEmpty) {
                              return noData(
                                  title: 'No cancelled Session',
                                  context: context);
                            } else {
                              return UpcomingOrderItem(
                                data: sessionList,
                                showRebookButton: true,
                                rebookPressed: () {
                                  _bottomSheet(
                                      context: context,
                                      showBookAgainText: true);
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loadingShimmer() {
    return ListView.separated(
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      shimmerEffect(
                          widget: SkeletonWidget(
                        height: 10,
                        width: deviceWidth(context) * 0.30,
                      )),
                      shimmerEffect(
                          widget: SkeletonWidget(
                        height: 40,
                        width: deviceWidth(context) * 0.20,
                      )),
                    ],
                  ),
                  heightGap(10),
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
                ]),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return heightGap(10);
      },
    );
  }

  Future<void> _bottomSheet({
    BuildContext? context,
    bool showBookAgainText = false,
    bool navigateToPackageScreen = false,
  }) async {
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
                    const TextWidget(
                      text: 'Select Time',
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
                          if (showBookAgainText) {
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
                                            const TextWidget(
                                              text: 'Congrats',
                                              color: AppColors.greenLight,
                                              fontSize: 24,
                                              fontFamily: AppFonts.poppins,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            const TextWidget(
                                              text:
                                                  'your new appointment is at 5.30 PM',
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
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BottomBarScreen(),
                                                ),
                                                (route) => false,
                                              );
                                            },
                                            text: 'Go to Home'),
                                      ]),
                                );
                              },
                            );
                          } else if (navigateToPackageScreen) {
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
                                            const TextWidget(
                                              text: 'Congrats',
                                              color: AppColors.greenLight,
                                              fontSize: 24,
                                              fontFamily: AppFonts.poppins,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            const TextWidget(
                                              text:
                                                  'yes you booked successfully',
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
                                            text: 'Go to Home'),
                                      ]),
                                );
                              },
                            );
                          }
                        },
                        text: showBookAgainText ? 'Book Again' : 'Book Session',
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
}
