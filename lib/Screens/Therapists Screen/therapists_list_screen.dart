import 'dart:developer';
import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Models/pyschologist_list_model.dart';
import 'package:expathy/Providers/Psychologists%20Provider/psychologists_provider.dart';
import 'package:expathy/Screens/Question%20Answer%20Screen/first_question_screen.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/horzontal_two_button_widget.dart';
import 'package:expathy/Widgets/therapists_list_item.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Providers/User Provider/user_provider.dart';
import '../../Utils/app_fonts.dart';
import '../../Widgets/skeleton_widget.dart';

class TherapistsListScreen extends StatefulWidget {
  final bool isFromHome;
  final bool showChangeLanguageDialog;
  final bool showBackButton;
  const TherapistsListScreen(
      {Key? key,
      this.isFromHome = false,
      this.showChangeLanguageDialog = false,
      this.showBackButton = true})
      : super(key: key);

  @override
  State<TherapistsListScreen> createState() => _TherapistsListScreenState();
}

class _TherapistsListScreenState extends State<TherapistsListScreen> {
  late Future<List<PsychologistList>?> psychologistsListFuture;
  bool isTherapistsSelectUpdate = false;
  int? selectedIndex;

  @override
  void initState() {
    psychologistsListFuture = context
        .read<PsychologistsProvider>()
        .fetchPsychologistsListApi(
          context: context,
        )
        .whenComplete(() {
      if (widget.showChangeLanguageDialog) {
        _showDialog();
      }
    });

    super.initState();
  }

  _showDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (context.mounted) {
      await showWarningDialog(
          context: context,
          barrierDismissible: false,
          radius: 16,
          title: 'Want to Change Language',
          content:
              'This therapist list is according to your old chosen language. You want to change the language? ',
          widget: [
            HorizontalTwoButtonWidget(
              text1: 'No',
              text2: 'Yes',
              text1Tap: () {
                Navigator.of(context).pop();
              },
              text2Tap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) =>
                          const FirstQuestionScreen(showLogoutDialog: true),
                    ),
                    (route) => false);
              },
            )
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: GradientBackgroundWidget(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 20.0, bottom: 0.0),
            child: Column(
              children: [
                if (widget.showBackButton)
                  ToolBarWidget(
                    iconColor: AppColors.white,
                    onTap: () {
                      /* Navigator.of(context).pop();*/
                    },
                  ),
                if (!widget.showBackButton)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            /* sharedPrefs?.clear();
                            sharedPrefs?.setBool(
                                AppStrings.isFirstTimeOnApp, false);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const PreHomeScreen(),
                              ),
                              (route) => false,
                            );*/
                            logOut(context: context);
                          },
                          child: const Icon(
                            Icons.logout,
                            color: AppColors.white,
                          )),
                    ],
                  ),
                heightGap(24),
                InkWell(
                  onTap: () {},
                  child: const TextWidget(
                    text: 'Best matches for you',
                    textAlign: TextAlign.center,
                    fontSize: 28,
                    color: AppColors.white,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                heightGap(25),
                Expanded(
                  child: CustomFutureBuilder<List<PsychologistList>?>(
                    loaderWidget: loadingShimmer(),
                    future: psychologistsListFuture,
                    noInternetOnPressed: () {
                      setState(() {
                        psychologistsListFuture = context
                            .read<PsychologistsProvider>()
                            .fetchPsychologistsListApi(
                              context: context,
                            );
                      });
                    },
                    data: (snapshot) {
                      return ListView.builder(
                        itemCount: snapshot?.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          log(snapshot?[index].name ?? '');
                          return TherapistsListItem(
                            psychologist: snapshot?[index],
                            isTherapistsSelecting: selectedIndex == index
                                ? isTherapistsSelectUpdate
                                : false,
                            selectButtonPressed: () {
                              if (widget.isFromHome) {
                                Navigator.of(context).pop();
                              } else {
                                selectedIndex = index;
                                callUpdateProfileApi(
                                    therapistsId: snapshot?[index].id);
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> callUpdateProfileApi({String? therapistsId}) async {
    setState(() {
      isTherapistsSelectUpdate = true;
    });
    await context.read<UserProvider>().updateProfileApi(
          therapistsId: therapistsId,
          isFromSelectTherapistScreen: true,
          context: context,
        );
    setState(() {
      isTherapistsSelectUpdate = false;
    });
  }

  Widget loadingShimmer() {
    return Column(
      children: [
        heightGap(20),
        Expanded(
          child: ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: shimmerEffect(
                  widget: const SkeletonWidget(
                    radius: 30,
                    height: 40,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/*
import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/therapists_list_item.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_fonts.dart';

class TherapistsListScreen extends StatefulWidget {
  final bool isFromHome;
  const TherapistsListScreen({Key? key, this.isFromHome = false})
      : super(key: key);

  @override
  State<TherapistsListScreen> createState() => _TherapistsListScreenState();
}

class _TherapistsListScreenState extends State<TherapistsListScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: GradientBackgroundWidget(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 20.0, bottom: 0.0),
            child: Column(
              children: [
                ToolBarWidget(
                  iconColor: AppColors.white,
                  onTap: () => Navigator.of(context).pop(),
                ),
                heightGap(24),
                const TextWidget(
                  text: 'Best matches for you',
                  textAlign: TextAlign.center,
                  fontSize: 28,
                  color: AppColors.white,
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w500,
                ),
                heightGap(25),
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TherapistsListItem(
                        isFromHome: widget.isFromHome,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
