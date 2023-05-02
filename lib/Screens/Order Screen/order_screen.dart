import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/helper_methods.dart';
import 'package:expathy/Widgets/upcoming_order_item.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/toolbar_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
        body: GradientBackgroundWidget(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, right: 16, left: 16),
                  child: ToolBarWidget(
                    onTap: () {},
                    showArrowIcon: false,
                    title: 'Orders',
                  ),
                ),
                heightGap(24),
                SizedBox(
                  height: 55,
                  child: AppBar(
                    backgroundColor: AppColors.white,
                    bottom: const TabBar(
                      labelColor: AppColors.yellow,
                      unselectedLabelColor: AppColors.black,
                      indicatorColor: AppColors.yellow,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 4,
                      tabs: [
                        Tab(
                          text: 'Upcoming',
                        ),
                        Tab(text: 'Completed'),
                        Tab(text: 'Cancelled'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, right: 16, left: 16),
                    child: TabBarView(
                      children: [
                        UpcomingOrderItem(
                          cancelPressed: () {},
                          postponePressed: () {},
                        ),
                        const UpcomingOrderItem(showRebookButton: true),
                        const UpcomingOrderItem(showRebookButton: true),
                      ],
                    ),
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
