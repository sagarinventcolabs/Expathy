import 'package:expathy/Providers/User%20Provider/user_provider.dart';
import 'package:expathy/Screens/Profile%20Screen/edit_profile_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/change_language_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/change_password_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/invite_friends_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/manage_notification_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/personal_information_screen.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/svg_picture.dart';
import 'package:expathy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/navigation_services.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/horzontal_two_button_widget.dart';
import '../../Widgets/toolbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Setting Screens/notification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider authProvider =
        Provider.of<UserProvider>(context, listen: true);
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToolBarWidget(
                    onTap: () {},
                    showArrowIcon: false,
                    title: AppLocalizations.of(context)!.profile,
                  ),
                  heightGap(20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: sharedPrefs
                                            ?.getString(AppStrings.userName) ??
                                        '',
                                    fontSize: 20,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidget(
                                    text: sharedPrefs
                                            ?.getString(AppStrings.email) ??
                                        '',
                                    fontSize: 18,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ]),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ));
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(Icons.edit,
                                  color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  heightGap(10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          tileWidget(
                              title:
                                  AppLocalizations.of(context)!.changePassword,
                              icon: AppImages.lockIcon,
                              onTap: () {
                                NavigationServices.push(
                                    context: context,
                                    screen: const ChangePasswordScreen());
                              }),
                          tileWidget(
                              title:
                                  AppLocalizations.of(context)!.inviteFriends,
                              icon: AppImages.personIcon,
                              onTap: () {
                                NavigationServices.push(
                                    context: context,
                                    screen: const InviteScreen());
                              }),
                          divider(),
                          tileWidget(
                              title:
                                  AppLocalizations.of(context)!.changeLanguage,
                              icon: AppImages.languageIcon,
                              onTap: () {
                                NavigationServices.push(
                                    context: context,
                                    screen: const ChangeLanguageScreen());
                              }),
                          tileWidget(
                              title: AppLocalizations.of(context)!
                                  .manageNotification,
                              icon: AppImages.notiIcon,
                              onTap: () {
                                NavigationServices.push(
                                    context: context,
                                    screen: const ManageNotificationScreen());
                              }),
                          tileWidget(
                              title: 'Notification',
                              icon: AppImages.notiIcon,
                              onTap: () {
                                NavigationServices.push(
                                    context: context,
                                    screen: const NotificationScreen());
                              }),
                          divider(),
                          tileWidget(
                              title: AppLocalizations.of(context)!.aboutUs,
                              icon: AppImages.aboutIcon,
                              onTap: () {
                                NavigationServices.push(
                                  context: context,
                                  screen: const PersonalInformationScreen(
                                      type: 'About Us'),
                                );
                              }),
                          tileWidget(
                              title: AppLocalizations.of(context)!
                                  .cancellationPolicy,
                              icon: AppImages.policyIcon,
                              onTap: () {
                                NavigationServices.push(
                                  context: context,
                                  screen: const PersonalInformationScreen(
                                      type: 'Cancellation Policy'),
                                );
                              }),
                          tileWidget(
                              title:
                                  AppLocalizations.of(context)!.privacyPolicy,
                              icon: AppImages.privacyIcon,
                              onTap: () {
                                NavigationServices.push(
                                  context: context,
                                  screen: const PersonalInformationScreen(
                                      type: 'Privacy Policy'),
                                );
                              }),
                          tileWidget(
                              title: AppLocalizations.of(context)!.termsOfUse,
                              icon: AppImages.termsIcon,
                              onTap: () {
                                NavigationServices.push(
                                  context: context,
                                  screen: const PersonalInformationScreen(
                                      type: 'Terms of Use'),
                                );
                              }),
                          divider(),
                          tileWidget(
                              title:
                                  AppLocalizations.of(context)!.deleteAccount,
                              icon: AppImages.deleteIcon,
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return Hero(
                                      tag: '',
                                      child: AlertDialog(
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
                                                  Image.asset(
                                                      AppImages.errorGif,
                                                      width: 120,
                                                      height: 120),
                                                  heightGap(5),
                                                  TextWidget(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .areYouSureToDeleteAccount,
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                              heightGap(18),
                                              Consumer<UserProvider>(
                                                builder:
                                                    (context, value, child) {
                                                  return value
                                                          .showLoadingIndicator
                                                      ? const Center(
                                                          child:
                                                              CupertinoActivityIndicator(),
                                                        )
                                                      : HorizontalTwoButtonWidget(
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
                                                            authProvider
                                                                .deleteAccountApi(
                                                                    context:
                                                                        context);
                                                          },
                                                        );
                                                },
                                              ),
                                            ]),
                                      ),
                                    );
                                  },
                                );
                              }),
                          tileWidget(
                              title: AppLocalizations.of(context)!.logOut,
                              icon: AppImages.logoutIcon,
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return Hero(
                                      tag: '',
                                      child: AlertDialog(
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
                                                  TextWidget(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .areYouSureToLogOut,
                                                    fontSize: 15,
                                                    fontFamily:
                                                        AppFonts.poppins,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ],
                                              ),
                                              heightGap(18),
                                              HorizontalTwoButtonWidget(
                                                text1: AppLocalizations.of(
                                                        context)!
                                                    .no,
                                                text1Tap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                text2: AppLocalizations.of(
                                                        context)!
                                                    .yes,
                                                text2Tap: () {
                                                  logOut(context: context);
                                                },
                                              ),
                                            ]),
                                      ),
                                    );
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  heightGap(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tileWidget({String? title, String? icon, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: TextWidget(
          text: title ?? '',
          fontSize: 16,
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w400,
        ),
        leading: SvgPic(image: icon ?? ''),
        trailing: const Icon(Icons.arrow_forward_ios),
        minLeadingWidth: 10,
      ),
    );
  }

  Widget divider() {
    return const Divider(
      color: AppColors.checkBoxBorderColor,
      height: 2,
      indent: 10,
      endIndent: 10,
    );
  }
}
