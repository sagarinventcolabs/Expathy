import 'package:expathy/Models/dashboard_model.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Models/article_model.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_images.dart';
import '../../Widgets/article_item.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/toolbar_widget.dart';

class AllArticlesScreen extends StatefulWidget {
  final List<Articles>? articleList;

  const AllArticlesScreen({Key? key, this.articleList}) : super(key: key);

  @override
  State<AllArticlesScreen> createState() => _AllArticlesScreenState();
}

class _AllArticlesScreenState extends State<AllArticlesScreen> {
  /* List<ArticleModel> articleList = [
    ArticleModel(
      image: AppImages.ar5,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
    ArticleModel(
      image: AppImages.ar2,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
    ArticleModel(
      image: AppImages.ar3,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
    ArticleModel(
      image: AppImages.ar4,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
    ArticleModel(
      image: AppImages.ar1,
      description:
          'From Panic to Peace: A Guide to Navigating and Conquering Panic Attacks',
      date: '4 April 2023, Tuesday',
    ),
  ];*/

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
                  title: 'Articles',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                heightGap(24),
                Expanded(
                  child: ListView.separated(
                    itemCount: widget.articleList!.length,
                    itemBuilder: (context, index) {
                      final articleData = widget.articleList?[index];
                      return ArticleItem(
                        articleData: articleData,
                        isFromAllArticleScreen: true,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return heightGap(16);
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
