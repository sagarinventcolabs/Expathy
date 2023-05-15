/*
import 'dart:developer';

import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Models/pyschologist_list_model.dart';
import 'package:expathy/Providers/Psychologists%20Provider/psychologists_provider.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/therapists_list_item.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Utils/app_fonts.dart';
import '../../Widgets/skeleton_widget.dart';

class TherapistsListScreen extends StatefulWidget {
  final bool isFromHome;
  const TherapistsListScreen({Key? key, this.isFromHome = false})
      : super(key: key);

  @override
  State<TherapistsListScreen> createState() => _TherapistsListScreenState();
}

class _TherapistsListScreenState extends State<TherapistsListScreen> {
  late Future<List<PsychologistList>?> psychologistsListFuture;

  @override
  void initState() {
    psychologistsListFuture =
        context.read<PsychologistsProvider>().fetchPsychologistsListApi(
              context: context,
            );
    super.initState();
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
                            isFromHome: widget.isFromHome,
                            psychologist: snapshot?[index],
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
*/

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
