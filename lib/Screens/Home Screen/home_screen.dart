import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Screens/Article%20Screen/article_detail_screen.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/horzontal_two_button_widget.dart';
import 'package:expathy/Widgets/info_widget.dart';
import 'package:expathy/Widgets/svg_picture.dart';
import 'package:expathy/Widgets/upcoming_session_item.dart';
import 'package:expathy/Widgets/view_all_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../Therapists Screen/therapists_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool showDropDown = false;
  bool showChangeTherapistsOption = false;
  String dropdownValue = 'Dog';

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
                            const TextWidget(
                              text: 'John, we are here for you',
                              textAlign: TextAlign.center,
                              fontSize: 22,
                              color: AppColors.white,
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      heightGap(24),
                      const TextWidget(
                        text: 'Active Plan',
                        fontSize: 18,
                        color: AppColors.white,
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w400,
                      ),
                      heightGap(8),
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        TextWidget(
                                          text: 'Free Plan',
                                          textAlign: TextAlign.center,
                                          fontSize: 18,
                                          fontFamily: AppFonts.poppins,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        TextWidget(
                                          text: '(10 min./session)',
                                          textAlign: TextAlign.center,
                                          fontSize: 12,
                                          fontFamily: AppFonts.poppins,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButtonWidget(
                                    onPressed: () {},
                                    primary: AppColors.yellow,
                                    text: AppStrings.upgrade,
                                  ),
                                ],
                              ),
                              const Divider(
                                  color: AppColors.checkBoxBorderColor),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    planItem(heading: '', value: '02'),
                                    planItem(heading: '', value: '02'),
                                    planItem(heading: '', value: '02'),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      heightGap(24),
                      Row(
                        children: [
                          const Expanded(
                            child: TextWidget(
                              text: 'Your Therapist',
                              fontSize: 18,
                              color: AppColors.white,
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const SvgPic(image: AppImages.reload),
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 1, color: AppColors.white)),
                            label: const TextWidget(
                              text: 'Change',
                              fontSize: 14,
                              color: AppColors.white,
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w400,
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
                                name: 'Norma Warren',
                                type: 'Biopsychologists',
                                description:
                                    'Vestibsfevulum semwe acssscv fre porttitor...',
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const TherapistsDetailScreen(),
                                  ));
                                },
                              ),
                              heightGap(10),
                              expertiseButton(),
                              heightGap(10),
                              HorizontalTwoButtonWidget(
                                text1: 'Free Session NOW',
                                text1Tap: () {
                                  _bottomsheet(context: context);
                                },
                                text2: 'Book Full Session',
                                text2Tap: () {
                                  _bottomsheet(context: context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      heightGap(24),
                      const ViewAllRowWidget(text: 'Upcomping Sessions'),
                      heightGap(8),
                      SizedBox(
                        height: 185,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          clipBehavior: Clip.none,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return UpComingSessionItem(
                              cancelPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      content: StatefulBuilder(
                                        builder: (context, setState) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Column(
                                                children: [
                                                  Lottie.asset(
                                                      AppImages.warningJson,
                                                      width: 100,
                                                      height: 100),
                                                  heightGap(5),
                                                  const TextWidget(
                                                    text:
                                                        'Are you sure to CANCEL the session?',
                                                    fontSize: 16,
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                              heightGap(18),
                                              HorizontalTwoButtonWidget(
                                                text1: 'No',
                                                text1Tap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                text2: 'Yes',
                                                text2Tap: () {
                                                  setState(() {
                                                    showDropDown = true;
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
                                                      heightGap(18),
                                                      const TextWidget(
                                                        text: 'Select reason',
                                                        fontSize: 14,
                                                        fontFamily:
                                                            AppFonts.poppins,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      const TextWidget(
                                                        text:
                                                            'Donec vitae mi vulputate, suscipit urna in, malesuada nisl. Pellentesque laoreet pretium nisl, et pulvinar massa.',
                                                        fontSize: 12,
                                                        color:
                                                            AppColors.greyText,
                                                        fontFamily:
                                                            AppFonts.poppins,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      heightGap(18),
                                                      Container(
                                                        child:
                                                            DropdownButtonFormField(
                                                          isDense: true,
                                                          icon: Icon(
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
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .checkBoxBorderColor,
                                                                  width: 1),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .checkBoxBorderColor,
                                                                  width: 1),
                                                            ),
                                                            filled: true,
                                                            fillColor: AppColors
                                                                .borderColor,
                                                          ),
                                                          value: dropdownValue,
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              dropdownValue =
                                                                  newValue!;
                                                              showChangeTherapistsOption =
                                                                  true;
                                                            });
                                                          },
                                                          items: <String>[
                                                            'Dog',
                                                            'Cat',
                                                            'Tiger',
                                                            'Lion'
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: TextWidget(
                                                                text: value,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    AppFonts
                                                                        .poppins,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
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
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  heightGap(18),
                                                  HorizontalTwoButtonWidget(
                                                    text1: 'No',
                                                    text1Tap: () {},
                                                    text2: 'Yes',
                                                    text2Tap: () {},
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
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Column(
                                              children: [
                                                Lottie.asset(
                                                    AppImages.warningJson,
                                                    width: 100,
                                                    height: 100),
                                                heightGap(5),
                                                const TextWidget(
                                                  text: 'No worries,',
                                                  color: AppColors.greenLight,
                                                  fontSize: 24,
                                                  fontFamily: AppFonts.poppins,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                const TextWidget(
                                                  text:
                                                      'just select another timeslot',
                                                  fontFamily: AppFonts.poppins,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                            heightGap(18),
                                            ElevatedButtonWidget(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  _bottomsheet(
                                                      context: context,
                                                      showBookAgainText: true);
                                                },
                                                text: 'Select'),
                                          ]),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      heightGap(24),
                      const ViewAllRowWidget(
                          text: 'Articles', viewAllColor: AppColors.blue),
                      heightGap(8),
                      SizedBox(
                        height: 265,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          physics: const BouncingScrollPhysics(),
                          clipBehavior: Clip.none,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ArticleDetailScreen(),
                                ));
                              },
                              child: Container(
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
                                          topLeft: Radius.circular(12)),
                                      child: SizedBox(
                                        height: 150,
                                        child: Image.asset(
                                          AppImages.article,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TextWidget(
                                            text:
                                                'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
                                            fontSize: 18,
                                            color: AppColors.black,
                                            fontFamily: AppFonts.poppins,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          heightGap(10),
                                          const TextWidget(
                                            text: '4 April 2023, Tuesday',
                                            textAlign: TextAlign.center,
                                            fontSize: 12,
                                            color: AppColors.greyText,
                                            fontFamily: AppFonts.poppins,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      heightGap(10),
                    ],
                  ),
                  const Positioned(
                      right: 0,
                      top: 40,
                      child: SvgPic(
                        image: AppImages.notificationIcon,
                        color: AppColors.white,
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _bottomsheet(
      {BuildContext? context, bool showBookAgainText = false}) async {
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
                              borderRadius: BorderRadius.circular(100)),
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
                          headerMargin: EdgeInsets.only(left: 0)),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Column(
                                  children: [
                                    _showWeek(date),
                                    Expanded(child: _showDate(date)),
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
                                borderRadius: BorderRadius.circular(44)),
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
                              barrierDismissible: true, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
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

  Widget planItem({String? heading, String? value}) {
    return Column(
      children: const [
        TextWidget(
          text: 'Total Sessions',
          textAlign: TextAlign.center,
          fontSize: 13,
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w400,
        ),
        TextWidget(
          text: '02',
          textAlign: TextAlign.center,
          fontSize: 16,
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w500,
        ),
      ],
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
}
