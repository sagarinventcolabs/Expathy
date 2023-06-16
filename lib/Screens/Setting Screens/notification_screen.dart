import 'package:expathy/Providers/User%20Provider/user_provider.dart';
import 'package:expathy/Providers/User%20Provider/user_provider.dart';
import 'package:expathy/Providers/User%20Provider/user_provider.dart';
import 'package:expathy/Providers/User%20Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Models/notification_model.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/gradient_background_widget.dart';
import '../../Widgets/skeleton_widget.dart';
import '../../Widgets/toolbar_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationDoc>?> notificationListFuture;

  @override
  void initState() {
    notificationListFuture = context
        .read<UserProvider>()
        .notificationListApi(context: context, limit: 10, pageNumber: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ToolBarWidget(
                          title: 'Notifications',
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const Icon(Icons.more_vert, color: AppColors.white),
                    ],
                  ),
                ),
                heightGap(20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16))),
                      child: CustomFutureBuilder<List<NotificationDoc>?>(
                        loaderWidget: loadingShimmer(),
                        future: notificationListFuture,
                        noInternetOnPressed: () {},
                        data: (snapshot) {
                          if (snapshot!.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Lottie.asset(AppImages.emptyJson,
                                      width: 300, height: 300),
                                  const TextWidget(
                                    text: 'No notifications',
                                    color: AppColors.green,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return ListView.separated(
                              itemCount: snapshot.length,
                              itemBuilder: (context, index) {
                                final notification = snapshot[index];
                                return Dismissible(
                                  key: Key(index.toString()),
                                  onDismissed: (direction) {
                                    context
                                        .read<UserProvider>()
                                        .deleteNotificationApi(
                                            context: context,
                                            notificationId:
                                                notification.sId.toString(),
                                            index: index);
                                  },
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const TextWidget(
                                                text: 'Delete Notification'),
                                            content: const TextWidget(
                                                text:
                                                    'Are you sure you want to delete this notification'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: const TextWidget(
                                                    text: 'confirm'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const TextWidget(
                                                    text: 'no'),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    child: const Icon(
                                      Icons.delete,
                                      color: AppColors.white,
                                      size: 40,
                                    ),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<UserProvider>()
                                          .readNotificationApi(
                                              context: context,
                                              notificationId:
                                                  notification.sId.toString(),
                                              index: index);
                                    },
                                    child: Consumer<UserProvider>(
                                      builder: (context, value, child) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: value
                                                      .notificationList![index]
                                                      .isRead!
                                                  ? AppColors.white
                                                  : AppColors
                                                      .notificationUnread,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(16),
                                                      topLeft:
                                                          Radius.circular(16))),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                right: 16,
                                                left: 16,
                                                bottom: 10.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          const CircleAvatar(
                                                            radius: 20,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    AppImages
                                                                        .girl),
                                                          ),
                                                          value
                                                                  .notificationList![
                                                                      index]
                                                                  .isRead!
                                                              ? const SizedBox()
                                                              : Positioned(
                                                                  right: 0,
                                                                  top: 0,
                                                                  child:
                                                                      Container(
                                                                    width: 10,
                                                                    height: 10,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                100),
                                                                        color: AppColors
                                                                            .blueLight),
                                                                  )),
                                                        ],
                                                      ),
                                                      widthGap(10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const TextWidget(
                                                            text:
                                                                'Daniel Hamilton',
                                                            fontSize: 16,
                                                            fontFamily: AppFonts
                                                                .poppins,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          TextWidget(
                                                            text: notification
                                                                    .message ??
                                                                '',
                                                            fontSize: 13,
                                                            color: AppColors
                                                                .greyText,
                                                            fontFamily: AppFonts
                                                                .poppins,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          TextWidget(
                                                            text: dateTimeFormat(
                                                                notification
                                                                        .createdAt ??
                                                                    ''),
                                                            fontSize: 13,
                                                            color: AppColors
                                                                .greyText,
                                                            fontFamily: AppFonts
                                                                .poppins,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // const Icon(Icons.more_vert),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  height: 0,
                                  thickness: 1,
                                );
                              },
                            );
                          }
                        },
                      ),
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

  Widget loadingShimmer() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: shimmerEffect(
                  widget: const SkeletonWidget(
                    radius: 8,
                    height: 60,
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
