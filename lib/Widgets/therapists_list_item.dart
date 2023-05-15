import 'package:expathy/Screens/Bottom%20Bar%20Screen/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import '../Common Widgets/elevated_button_widget.dart';
import '../Models/pyschologist_list_model.dart';
import '../Screens/Therapists Screen/therapists_detail_screen.dart';
import '../Utils/app_colors.dart';
import '../Utils/helper_methods.dart';
import 'info_widget.dart';

class TherapistsListItem extends StatelessWidget {
  final bool isFromHome;
  final PsychologistList? psychologist;
  const TherapistsListItem(
      {Key? key, this.isFromHome = false, this.psychologist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          InfoWidget(
            name: 'Norma Warren',
            type: 'Biopsychologists',
            /* name: psychologist?.name ?? '',
            type: psychologist?.type ?? '',*/
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TherapistsDetailScreen(),
              ));
            },
            showGreenIcon: false,
            description: 'Vestibsfevulum semwe acssscv fre porttitor...',
            /* description: psychologist?.description ?? '',*/
          ),
          heightGap(12),
          expertiseButton(),
          heightGap(12),
          ElevatedButtonWidget(
              onPressed: () {
                if (isFromHome) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BottomBarScreen(),
                  ));
                }
              },
              text: 'Select'),
        ]),
      ),
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
