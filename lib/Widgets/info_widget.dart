import 'package:expathy/Widgets/svg_picture.dart';
import 'package:flutter/material.dart';

import '../Common Widgets/text_widget.dart';
import '../Remote/api_config.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_fonts.dart';
import '../Utils/app_images.dart';
import '../Utils/helper_methods.dart';

class InfoWidget extends StatelessWidget {
  final String? name;
  final String? type;
  final String? description;
  final bool showGreenIcon;
  final String? imageUrl;
  final Function() onTap;

  const InfoWidget({
    Key? key,
    this.name,
    this.type,
    this.description,
    this.showGreenIcon = true,
    required this.onTap,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          circleImage(url: '$IMAGE_URL${imageUrl ?? ''}'),
          widthGap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget(
                      text: name ?? '',
                      fontSize: 18,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w500,
                    ),
                    widthGap(5),
                    if (showGreenIcon)
                      const SvgPic(image: AppImages.checkSymbol),
                  ],
                ),
                TextWidget(
                  text: type ?? '',
                  fontSize: 14,
                  color: AppColors.greyText,
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                ),
                heightGap(5),
                TextWidget(
                  text: description ?? '',
                  fontSize: 13,
                  maxLines: 1,
                  color: AppColors.black,
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
