import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../../Common Widgets/custom_future_builder.dart';
import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Models/personal_information_model.dart';
import '../../Providers/Auth Provider/auth_provider.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/skeleton_widget.dart';
import '../../Widgets/svg_picture.dart';
import '../../Widgets/toolbar_widget.dart';

class PersonalInformationScreen extends StatefulWidget {
  final String type;

  const PersonalInformationScreen({Key? key, required this.type})
      : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late Future<PersonalInfo?> personalInfoFuture;

  @override
  void initState() {
    personalInfoFuture = context.read<AuthProvider>().getPersonalInfoApi(
          context: context,
          type: 'Psychologist',
          slug: widget.type == 'About Us'
              ? 'about_us'
              : widget.type == 'Privacy Policy'
                  ? 'privacy_policy'
                  : widget.type == 'Cancellation Policy'
                      ? 'cancel'
                      : 'term',
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(deviceWidth(context),
                    (deviceHeight(context) * 0.50).toDouble()),
                //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: AuthScreenPainter(),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: deviceWidth(context) * 0.40,
                          height: deviceHeight(context) * 0.15,
                          child: const SvgPic(
                            image: AppImages.logoMain,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 20,
                        child: ToolBarWidget(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 16, left: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: TextWidget(
                                    text: widget.type,
                                    fontSize: 24,
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                heightGap(20),
                                CustomFutureBuilder<PersonalInfo?>(
                                  loaderWidget: loadingShimmer(),
                                  future: personalInfoFuture,
                                  noInternetOnPressed: () {
                                    setState(() {
                                      personalInfoFuture = context
                                          .read<AuthProvider>()
                                          .getPersonalInfoApi(
                                            context: context,
                                            type: 'Psychologist',
                                            slug: widget.type == 'About Us'
                                                ? 'about_us'
                                                : widget.type ==
                                                        'Privacy Policy'
                                                    ? 'privacy_policy'
                                                    : widget.type ==
                                                            'Cancellation Policy'
                                                        ? 'cancel'
                                                        : 'term',
                                          );
                                    });
                                  },
                                  data: (snapshot) {
                                    return Html(
                                        data: snapshot?.description ?? '');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingShimmer() {
    return ListView.builder(
      itemCount: 9,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              shimmerEffect(
                widget: const SkeletonWidget(
                  radius: 0,
                  height: 40,
                  width: double.infinity,
                ),
              ),
              heightGap(10),
              shimmerEffect(
                widget: const SkeletonWidget(
                  radius: 0,
                  height: 200,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
