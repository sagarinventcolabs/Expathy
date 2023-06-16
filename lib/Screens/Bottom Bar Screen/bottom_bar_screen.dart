import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:expathy/Screens/Buddy%20Screen/buddy_screen.dart';
import 'package:expathy/Screens/Home%20Screen/home_screen.dart';
import 'package:expathy/Screens/Order%20Screen/order_screen.dart';
import 'package:expathy/Screens/Profile%20Screen/profile_screen.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Widgets/svg_picture.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final _pageController = PageController(initialPage: 0);
  int maxCount = 5;

  final List<Widget> bottomBarPages = [
    const HomeScreen(),
    const OrderScreen(),
    //const ChatScreen(),
    //const ChatScreen(),
    const BuddyScreen(),
    const ProfileScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? AnimatedNotchBottomBar(
                pageController: _pageController,
                itemLabelStyle: const TextStyle(
                    color: AppColors.checkBoxBorderColor,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.7),
                color: Colors.white,
                showLabel: true,
                notchColor: AppColors.yellow,
                bottomBarItems: item,
                onTap: (index) {
                  _pageController.jumpToPage(
                    index,
                  );
                },
              )
            : null,
      ),
    );
  }

  List<BottomBarItem> item = [
    const BottomBarItem(
      inActiveItem: SvgPic(
        image: AppImages.homeIcon,
        color: Colors.grey,
      ),
      activeItem: SvgPic(
        image: AppImages.homeIcon,
        color: Colors.white,
      ),
      itemLabel: 'Home',
    ),
    const BottomBarItem(
      inActiveItem: SvgPic(
        image: AppImages.orderIcon,
        color: Colors.grey,
      ),
      activeItem: SvgPic(
        image: AppImages.orderIcon,
        color: Colors.white,
      ),
      itemLabel: 'Orders',
    ),
    /*const BottomBarItem(
      inActiveItem: Icon(
        Icons.chat,
        color: AppColors.checkBoxBorderColor,
      ),
      activeItem: Icon(
        Icons.chat,
        color: AppColors.white,
      ),
      itemLabel: 'Gossips',
    ),*/
    const BottomBarItem(
      inActiveItem: SvgPic(
        image: AppImages.buddyIcon,
        color: Colors.grey,
      ),
      activeItem: SvgPic(
        image: AppImages.buddyIcon,
        color: Colors.white,
      ),
      itemLabel: 'Buddy',
    ),
    const BottomBarItem(
      inActiveItem: SvgPic(
        image: AppImages.profileIcon,
        color: Colors.grey,
      ),
      activeItem: SvgPic(
        image: AppImages.profileIcon,
        color: Colors.white,
      ),
      itemLabel: 'Profile',
    ),
  ];
}
