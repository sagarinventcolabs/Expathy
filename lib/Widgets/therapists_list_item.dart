import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common Widgets/elevated_button_widget.dart';
import '../Models/pyschologist_list_model.dart';
import '../Screens/Therapists Screen/therapists_detail_screen.dart';
import '../Utils/app_colors.dart';
import '../Utils/helper_methods.dart';
import 'info_widget.dart';

class TherapistsListItem extends StatelessWidget {
  final PsychologistList? psychologist;
  final Function()? selectButtonPressed;
  final bool isTherapistsSelecting;

  const TherapistsListItem(
      {Key? key,
      this.psychologist,
      this.selectButtonPressed,
      this.isTherapistsSelecting = false})
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
            name: psychologist?.name ?? '',
            type: psychologist?.psychologistType?.name ?? '',
            imageUrl: psychologist?.profilePic ?? '',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TherapistsDetailScreen(
                    psychologistId: psychologist?.id,
                    isFromTherapistListScreen: true),
              ));
            },
            showGreenIcon: false,
            description: psychologist?.description ?? '',
          ),
          heightGap(12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: psychologist?.areaOfExperties?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.yellowLight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: TextWidget(
                        text: psychologist?.areaOfExperties?[index].name ?? '',
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          heightGap(12),
          isTherapistsSelecting
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : ElevatedButtonWidget(
                  onPressed: selectButtonPressed, text: 'Select'),
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
