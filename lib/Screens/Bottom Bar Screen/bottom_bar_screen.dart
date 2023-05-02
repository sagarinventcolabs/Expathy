import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:expathy/Screens/Chat%20Screen/chat_screen.dart';
import 'package:expathy/Screens/Home%20Screen/home_screen.dart';
import 'package:expathy/Screens/Order%20Screen/order_screen.dart';
import 'package:expathy/Screens/Profile%20Screen/profile_screen.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  int maxCount = 5;

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomeScreen(),
    const OrderScreen(),
    const ChatScreen(),
    const ChatScreen(),
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
    return Scaffold(
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
    );
  }

  List<BottomBarItem> item = [
    const BottomBarItem(
      inActiveItem: Icon(
        Icons.home_filled,
        color: AppColors.checkBoxBorderColor,
      ),
      activeItem: Icon(
        Icons.home_filled,
        color: AppColors.white,
      ),
      itemLabel: 'Home',
    ),
    const BottomBarItem(
      inActiveItem: Icon(
        Icons.menu,
        color: AppColors.checkBoxBorderColor,
      ),
      activeItem: Icon(
        Icons.menu,
        color: AppColors.white,
      ),
      itemLabel: 'Orders',
    ),
    const BottomBarItem(
      inActiveItem: Icon(
        Icons.chat,
        color: AppColors.checkBoxBorderColor,
      ),
      activeItem: Icon(
        Icons.chat,
        color: AppColors.white,
      ),
      itemLabel: 'Gossips',
    ),
    const BottomBarItem(
      inActiveItem: Icon(
        Icons.person_outline_outlined,
        color: AppColors.checkBoxBorderColor,
      ),
      activeItem: Icon(
        Icons.person_outline_outlined,
        color: AppColors.white,
      ),
      itemLabel: 'Matching',
    ),
    const BottomBarItem(
      inActiveItem: Icon(
        Icons.person,
        color: AppColors.checkBoxBorderColor,
      ),
      activeItem: Icon(
        Icons.person,
        color: AppColors.white,
      ),
      itemLabel: 'Profile',
    ),
  ];
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow, child: const Center(child: Text('Page 1')));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green, child: const Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue, child: const Center(child: Text('Page 4')));
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
        child: const Center(child: Text('Page 4')));
  }
}
