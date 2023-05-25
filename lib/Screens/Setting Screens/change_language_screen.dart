import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Models/flag_model.dart';
import '../../Models/language_list_model.dart';
import '../../Providers/Question Provider/question_provider.dart';
import '../../Providers/User Provider/user_provider.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/skeleton_widget.dart';
import '../../Widgets/svg_picture.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  int? selectedIndex;
  String? selectedLanguageCode;
  String? selectedLanguageId;
  late Future<LanguageListModel?> languageListFuture;
  bool isProfileUpdate = false;
  List<FlagModel> flagList = [
    FlagModel(image: AppImages.f6, name: 'English', languageCode: 'en'),
    FlagModel(image: AppImages.f7, name: 'Español', languageCode: 'en'),
    FlagModel(image: AppImages.f17, name: 'العربية', languageCode: 'ar'),
    FlagModel(image: AppImages.f13, name: 'Polski', languageCode: 'en'),
    FlagModel(image: AppImages.f1, name: 'Turkce', languageCode: 'en'),
    FlagModel(image: AppImages.f9, name: 'Farsi', languageCode: 'en'),
    FlagModel(image: AppImages.f11, name: 'हिन्दी', languageCode: 'hi'),
    FlagModel(image: AppImages.f5, name: 'Deutsch', languageCode: 'en'),
    FlagModel(image: AppImages.f2, name: 'Português', languageCode: 'en'),
    FlagModel(image: AppImages.f12, name: 'Italiano', languageCode: 'en'),
    FlagModel(image: AppImages.f3, name: 'Portugese', languageCode: 'en'),
    FlagModel(image: AppImages.f14, name: 'Română', languageCode: 'en'),
    FlagModel(image: AppImages.f15, name: 'Ελληνικά', languageCode: 'en'),
    FlagModel(image: AppImages.f4, name: 'Čeština', languageCode: 'en'),
    FlagModel(image: AppImages.f10, name: 'Hrvatski', languageCode: 'en'),
    FlagModel(image: AppImages.f8, name: 'Magyar', languageCode: 'en'),
    FlagModel(image: AppImages.f16, name: 'български', languageCode: 'en'),
  ];

  @override
  void initState() {
    languageListFuture = context
        .read<QuestionProvider>()
        .fetchLanguageListApi(
          context: context,
        )
        .whenComplete(() {
      /*  if (widget.showLogoutDialog) {
        _showDialog();
      }*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(
                    deviceWidth(context),
                    (deviceHeight(context) * 0.50)
                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: AuthScreenPainter(),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: deviceWidth(context) * 0.40,
                          height: deviceHeight(context) * 0.15,
                          child: const SvgPic(
                            image: AppImages.logoMain,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 20,
                        child: ToolBarWidget(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, right: 16, left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: TextWidget(
                                  text: AppLocalizations.of(context)!
                                      .changeLanguage,
                                  color: AppColors.black,
                                  fontSize: 24,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              heightGap(16),
                              /*  Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      final flagData = flagList[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              */ /* flagData.isSelected =
                                                  !flagData.isSelected;*/ /*
                                              selectedIndex = index;
                                              selectedLanguageCode = flagData
                                                  .languageCode
                                                  .toString();
                                            });
                                          },
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            width: double.infinity,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: selectedIndex == index
                                                  ? AppColors.yellow
                                                  : AppColors.white,
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.borderColor),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    flagData.image ?? '',
                                                    width: 33,
                                                    height: 24,
                                                  ),
                                                  widthGap(10),
                                                  TextWidget(
                                                    text: flagData.name ?? '',
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14,
                                                    color: AppColors.black,
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return heightGap(10);
                                    },
                                    itemCount: flagList.length),
                              ),*/
                              Expanded(
                                child: CustomFutureBuilder<LanguageListModel?>(
                                  loaderWidget: loadingShimmer(),
                                  future: languageListFuture,
                                  noInternetOnPressed: () {
                                    setState(() {
                                      languageListFuture = context
                                          .read<QuestionProvider>()
                                          .fetchLanguageListApi(
                                            context: context,
                                          );
                                    });
                                  },
                                  data: (snapshot) {
                                    return ListView.separated(
                                        itemBuilder: (context, index) {
                                          final flagData =
                                              snapshot?.data?.data?[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex = index;
                                                  selectedLanguageCode =
                                                      flagData?.value
                                                          .toString();
                                                  selectedLanguageId =
                                                      flagData?.id.toString();
                                                });
                                              },
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Container(
                                                width: double.infinity,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: selectedIndex == index
                                                      ? AppColors.yellow
                                                      : AppColors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColors
                                                          .borderColor),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Row(
                                                    children: [
                                                      /* Image.asset(
                                                        flagData.image ?? '',
                                                        width: 33,
                                                        height: 24,
                                                      ),
                                                      widthGap(10),*/
                                                      TextWidget(
                                                        text: flagData?.name ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.center,
                                                        fontSize: 14,
                                                        color: selectedIndex ==
                                                                index
                                                            ? AppColors.white
                                                            : AppColors.black,
                                                        fontFamily:
                                                            AppFonts.poppins,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return heightGap(10);
                                        },
                                        itemCount:
                                            snapshot?.data?.data?.length ?? 0);
                                  },
                                ),
                              ),
                              heightGap(16),
                              isProfileUpdate
                                  ? const Center(
                                      child: CupertinoActivityIndicator(),
                                    )
                                  : ElevatedButtonWidget(
                                      onPressed: () {
                                        callUpdateProfileApi();
                                      },
                                      text:
                                          AppLocalizations.of(context)!.change,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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

  Future<void> callUpdateProfileApi() async {
    setState(() {
      isProfileUpdate = true;
    });
    await context.read<UserProvider>().updateProfileApi(
          language: selectedLanguageCode ?? '',
          languageId: selectedLanguageId ?? '',
          isFromChangeLanguageScreen: true,
          context: context,
        );
    setState(() {
      isProfileUpdate = false;
    });
  }
}
