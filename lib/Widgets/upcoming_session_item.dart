import 'package:expathy/Widgets/date_time_item.dart';
import 'package:flutter/material.dart';
import '../Models/dashboard_model.dart';
import '../Utils/app_colors.dart';
import '../Utils/helper_methods.dart';
import 'horzontal_two_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpComingSessionItem extends StatelessWidget {
  final Function() postponePressed;
  final Function() cancelPressed;
  final Upcoming? upcoming;

  const UpComingSessionItem(
      {Key? key,
      required this.postponePressed,
      required this.cancelPressed,
      this.upcoming})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context) * 0.90,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: DateTimeItem(
                      heading: 'Date',
                      showHeading: false,
                      value:
                          '${getDateFormatted(data: upcoming?.date ?? '', showMonthTextMiddle: true)}, ${upcoming?.day?[0].toUpperCase()}${upcoming?.day?.substring(1)}',
                      crossAxisAlignment: CrossAxisAlignment.start),
                ),
                DateTimeItem(
                    heading: 'Time',
                    showHeading: false,
                    value:
                        '${convertTimeStampToTime(timeStamp: upcoming?.sessionTimeStamp ?? '')}',
                    crossAxisAlignment: CrossAxisAlignment.end),
              ],
            ),
            heightGap(10),
            const Divider(
              color: AppColors.checkBoxBorderColor,
            ),
            heightGap(10),
            HorizontalTwoButtonWidget(
              text1: AppLocalizations.of(context)!.cancel,
              text1Tap: cancelPressed,
              text2: AppLocalizations.of(context)!.postpone,
              text2Tap: postponePressed,
            ),
          ],
        ),
      ),
    );
  }
}
