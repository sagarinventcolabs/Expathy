import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common Widgets/text_widget.dart';
import '../Models/dashboard_model.dart';
import '../Utils/app_colors.dart';
import '../Utils/app_fonts.dart';
import '../Utils/helper_methods.dart';

class ArticleItem extends StatelessWidget {
  final Articles? articleData;
  final bool isFromAllArticleScreen;

  const ArticleItem(
      {Key? key, this.articleData, this.isFromAllArticleScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFromAllArticleScreen ? 0 : deviceWidth(context) * 0.55,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      /*child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.asset(
                articleData?.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextWidget(
                      text: articleData?.description ?? '',
                      fontSize: 16,
                      maxLines: 3,
                      color: AppColors.black,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  heightGap(10),
                  TextWidget(
                    text: articleData?.date ?? '',
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.greyText,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),*/
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /*ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: Image.network(
                articleData?.image ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),*/
          CachedNetworkImage(
            height: 120,
            imageUrl: articleData?.image ?? '',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(child: CupertinoActivityIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Center(
                  child: Icon(
                Icons.person,
                color: AppColors.green,
              )),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: articleData?.content ?? '',
                  fontSize: 14,
                  maxLines: 3,
                  color: AppColors.black,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                ),
                heightGap(10),
                TextWidget(
                  text: articleData?.createdAt ?? '',
                  fontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.greyText,
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
