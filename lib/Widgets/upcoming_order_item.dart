import 'package:expathy/Common%20Widgets/elevated_button_widget.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/date_time_item.dart';
import 'package:expathy/Widgets/horzontal_two_button_widget.dart';
import 'package:flutter/material.dart';

import '../Common Widgets/text_widget.dart';
import '../Models/get_session_model.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_fonts.dart';
import 'info_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcomingOrderItem extends StatefulWidget {
  final Function()? cancelPressed;
  final Function()? postponePressed;
  final Function()? rebookPressed;
  final bool showRebookButton;
  final List<Session>? data;

  const UpcomingOrderItem(
      {Key? key,
      this.cancelPressed,
      this.postponePressed,
      this.showRebookButton = false,
      this.rebookPressed,
      this.data})
      : super(key: key);

  @override
  State<UpcomingOrderItem> createState() => _UpcomingOrderItemState();
}

class _UpcomingOrderItemState extends State<UpcomingOrderItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.data?.length ?? 0,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final sessionData = widget.data?[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: TextWidget(
                          text: '#1234',
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButtonWidget(
                          onPressed: () {},
                          text: sessionData?.sessionType ?? '',
                          textColor: AppColors.black,
                          primary: AppColors.yellowLight,
                        ),
                      )
                    ],
                  ),
                  heightGap(10),
                  const Divider(color: AppColors.black, height: 2),
                  heightGap(10),
                  InfoWidget(
                    name: 'Norma Warren',
                    type: 'Biopsychologists',
                    onTap: () {},
                  ),
                  heightGap(10),
                  Row(
                    children: const [
                      Expanded(
                        child: DateTimeItem(
                            heading: 'Date',
                            value: '22 April 2023, Monday',
                            crossAxisAlignment: CrossAxisAlignment.start),
                      ),
                      DateTimeItem(
                          heading: 'Time',
                          value: '4.15 PM',
                          crossAxisAlignment: CrossAxisAlignment.end),
                    ],
                  ),
                  heightGap(10),
                  if (!widget.showRebookButton)
                    HorizontalTwoButtonWidget(
                      text1: AppLocalizations.of(context)!.cancel,
                      text1Tap: widget.cancelPressed,
                      text2: AppLocalizations.of(context)!.postpone,
                      text2Tap: widget.postponePressed,
                    ),
                  if (widget.showRebookButton)
                    ElevatedButtonWidget(
                        onPressed: widget.rebookPressed, text: 'Rebook'),
                ]),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return heightGap(10);
      },
    );
  }
}
