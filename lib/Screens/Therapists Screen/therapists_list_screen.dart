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
