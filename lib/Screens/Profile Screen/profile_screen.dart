import 'package:expathy/Screens/Auth%20Screens/prehome_screen.dart';
import 'package:expathy/Screens/Profile%20Screen/edit_profile_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/change_language_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/change_password_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/invite_friends_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/manage_notification_screen.dart';
import 'package:expathy/Screens/Setting%20Screens/personal_information_screen.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/svg_picture.dart';
import 'package:expathy/main.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/horzontal_two_button_widget.dart';
import '../../Widgets/toolbar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ToolBarWidget(
                    onTap: () {},
                    showArrowIcon: false,
                    title: 'Profile',
                  ),
                  heightGap(20),
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                /* CircleAvatar(
                                  radius: 45,
                                  backgroundImage: AssetImage(AppImages.girl),
                                ),*/
                                TextWidget(
                                  text: 'Olivia Rhye',
                                  fontSize: 20,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                ),
                                TextWidget(
                                  text: 'olivia@untitledui.com',
                                  fontSize: 18,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.w400,
                                ),
                              ]),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: InkWell(
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
                            child:
                                const Icon(Icons.edit, color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
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
                              title: 'Change Password',
                              icon: AppImages.lockIcon,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePasswordScreen(),
                                ));
                              }),
                          tileWidget(
                              title: 'Invite friends',
                              icon: AppImages.personIcon,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const InviteScreen(),
                                ));
                              }),
                          divider(),
                          tileWidget(
                              title: 'Change Language',
                              icon: AppImages.languageIcon,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangeLanguageScreen(),
                                ));
                              }),
                          tileWidget(
                              title: 'Manage Notification',
                              icon: AppImages.notiIcon,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ManageNotificationScreen(),
                                ));
                              }),
                          divider(),
                          tileWidget(
                              title: 'About Us',
                              icon: AppImages.aboutIcon,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalInformationScreen(
                                          type: 'About Us'),
                                ));
                              }),
                          tileWidget(
                              title: 'Cancellation Policy',
                              icon: AppImages.policyIcon,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalInformationScreen(
                                          type: 'Cancellation Policy'),
                                ));
                              }),
                          tileWidget(
                              title: 'Privacy Policy',
                              icon: AppImages.privacyIcon,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalInformationScreen(
                                          type: 'Privacy Policy'),
                                ));
                              }),
                          tileWidget(
                              title: 'Terms of Use',
                              icon: AppImages.termsIcon,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonalInformationScreen(
                                          type: 'Terms of Use'),
                                ));
                              }),
                          divider(),
                          tileWidget(
                              title: 'Delete Account',
                              icon: AppImages.deleteIcon,
                              onTap: () {
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
                                                Image.asset(AppImages.errorGif,
                                                    width: 120, height: 120),
                                                heightGap(5),
                                                const TextWidget(
                                                  text:
                                                      'Are you sure to DELETE Account?',
                                                  fontSize: 15,
                                                  fontFamily: AppFonts.poppins,
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
                                              text2Tap: () {},
                                            ),
                                          ]),
                                    );
                                  },
                                );
                              }),
                          tileWidget(
                              title: 'Log out',
                              icon: AppImages.logoutIcon,
                              onTap: () {
                                sharedPrefs?.clear();
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const PreHomeScreen(),
                                  ),
                                  (route) => false,
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
