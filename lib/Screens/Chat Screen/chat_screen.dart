import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Utils/app_colors.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/app_images.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';

import '../../Utils/helper_methods.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10.0),
          child: Column(
            children: [
              ToolBarWidget(
                  onTap: () {}, title: 'Gossips', showArrowIcon: false),
              heightGap(20),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemCount: 10,
                              shrinkWrap: true,
                              reverse: true,
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 12, bottom: 20),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Align(
                                  alignment: index.isEven
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (index.isOdd)
                                        const CircleAvatar(
                                          radius: 18,
                                          backgroundImage:
                                              AssetImage(AppImages.girl),
                                        ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: index.isEven
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                                text: 'John',
                                                fontSize: 14,
                                                color: AppColors.greyLightText,
                                                fontFamily: AppFonts.poppins,
                                                fontWeight: FontWeight.w400),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.80),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        index.isOdd ? 20 : 0),
                                                    topLeft: Radius.circular(
                                                        index.isEven ? 20 : 0),
                                                    bottomLeft:
                                                        const Radius.circular(
                                                            20),
                                                    bottomRight:
                                                        const Radius.circular(
                                                            20)),
                                                color: index.isEven
                                                    ? AppColors.greyBubble
                                                    : AppColors.green,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: TextWidget(
                                                        text:
                                                            'I have tried the app',
                                                        color: index.isOdd
                                                            ? AppColors.white
                                                            : AppColors.black,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            AppFonts.poppins,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (index.isEven)
                                        const CircleAvatar(
                                          radius: 18,
                                          backgroundImage:
                                              AssetImage(AppImages.girl),
                                        ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return heightGap(10);
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.only(
                                left: 0, bottom: 10, top: 10),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              border: Border.all(
                                  color: AppColors.checkBoxBorderColor),
                              color: AppColors.white,
                            ),
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 10, bottom: 10, top: 10),
                                        hintText: "Type your message",
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: AppFonts.poppins,
                                            fontSize: 16),
                                        border: InputBorder.none),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                FloatingActionButton(
                                  backgroundColor: AppColors.green,
                                  elevation: 0,
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          heightGap(10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
