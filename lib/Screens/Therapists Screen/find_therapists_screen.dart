import 'package:expathy/Common%20Widgets/custom_scaffold.dart';
import 'package:expathy/Screens/Therapists%20Screen/therapists_list_screen.dart';
import 'package:expathy/Widgets/gradient_background_widget.dart';
import 'package:expathy/Widgets/toolbar_widget.dart';
import 'package:flutter/material.dart';
import '../../Common Widgets/text_widget.dart';
import '../../Custom Painter /question_screen_custom_painter.dart';
import '../../Models/image_bubble_model.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';

class FindTherapistsScreen extends StatefulWidget {
  const FindTherapistsScreen({Key? key}) : super(key: key);

  @override
  State<FindTherapistsScreen> createState() => _FindTherapistsScreenState();
}

class _FindTherapistsScreenState extends State<FindTherapistsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  List<Mod> list = [
    Mod(
        top: 220, //this
        left: -100,
        image: AppImages.p4,
        beginXOffSet: 1.9, //this
        beginYOffSet: 0.1,
        endXOffSet: 1.2, //this
        endYOffSet: 0.11,
        imageHeight: 90,
        imageWidth: 90,
        alignment: Alignment.topLeft),
    Mod(
        top: 240, //this
        left: -100,
        image: AppImages.p3,
        beginXOffSet: 1.6, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.9, //this
        endYOffSet: 0.12,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),
    Mod(
        top: 260, //this
        left: -100,
        image: AppImages.p2,
        beginXOffSet: 1.3, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.6, //this
        endYOffSet: 0.11,
        imageHeight: 100,
        imageWidth: 100,
        alignment: Alignment.topLeft),

    ///

    Mod(
        top: 120, //this
        left: -100,
        image: AppImages.p1,
        beginXOffSet: 1.9, //this
        beginYOffSet: 0.1,
        endXOffSet: 1.2, //this
        endYOffSet: 0.12,
        imageHeight: 90,
        imageWidth: 90,
        alignment: Alignment.topLeft),
    Mod(
        top: 100, //this
        left: -100,
        image: AppImages.p16,
        beginXOffSet: 1.6, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.9, //this
        endYOffSet: 0.13,
        imageHeight: 100,
        imageWidth: 100,
        alignment: Alignment.topLeft),
    Mod(
        top: 140, //this
        left: -100,
        image: AppImages.p15,
        beginXOffSet: 1.3, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.6, //this
        endYOffSet: 0.105,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),

    ///
    Mod(
        top: 20, //this
        left: -100,
        image: AppImages.p14,
        beginXOffSet: 1.9, //this
        beginYOffSet: 0.1,
        endXOffSet: 1.2, //this
        endYOffSet: 0.12,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),
    Mod(
        top: 0, //this
        left: -100,
        image: AppImages.p11,
        beginXOffSet: 1.6, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.9, //this
        endYOffSet: 0.12,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),
    Mod(
        top: 20, //this
        left: -100,
        image: AppImages.p10,
        beginXOffSet: 1.3, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.6, //this
        endYOffSet: 0.07,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),
    Mod(
        top: 0, //this
        left: -100,
        image: AppImages.p9,
        beginXOffSet: 0.9, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.3, //this
        endYOffSet: 0.12,
        imageHeight: 100,
        imageWidth: 100,
        alignment: Alignment.topLeft),
    Mod(
        top: 50, //this
        left: -100,
        image: AppImages.p8,
        beginXOffSet: 0.6, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.1,
        endYOffSet: 0.11,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),
    Mod(
        top: 5, //this
        left: -100,
        image: AppImages.p7,
        beginXOffSet: 0.3, //this
        beginYOffSet: 0.1,
        endXOffSet: -0.1, //this
        endYOffSet: 0.108,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),

    ///
    Mod(
        top: 110, //this
        left: -100,
        image: AppImages.p6,
        beginXOffSet: 1.0, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.3, //this
        endYOffSet: 0.12,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),
    Mod(
        top: 160, //this
        left: -100,
        image: AppImages.p5,
        beginXOffSet: 0.7, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.1,
        endYOffSet: 0.11,
        imageHeight: 80,
        imageWidth: 80,
        alignment: Alignment.topLeft),
    Mod(
        top: 110, //this
        left: -100,
        image: AppImages.p4,
        beginXOffSet: 0.3, //this
        beginYOffSet: 0.1,
        endXOffSet: -0.2, //this
        endYOffSet: 0.12,
        imageHeight: 100,
        imageWidth: 100,
        alignment: Alignment.topLeft),

    ///
    Mod(
        top: 220, //this
        left: -100,
        image: AppImages.p3,
        beginXOffSet: 1.0, //this
        beginYOffSet: 0.1,
        endXOffSet: 0.3, //this
        endYOffSet: 0.14,
        imageHeight: 100,
        imageWidth: 100,
        alignment: Alignment.topLeft),
    Mod(
        top: 280, //this
        left: -100,
        image: AppImages.p2,
        beginXOffSet: 0.6, //this
        beginYOffSet: 0.1,
        endXOffSet: -0.1,
        endYOffSet: 0.09,
        imageHeight: 95,
        imageWidth: 95,
        alignment: Alignment.topLeft),
    Mod(
        top: 240, //this
        left: -100,
        image: AppImages.p1,
        beginXOffSet: 0.3, //this
        beginYOffSet: 0.1,
        endXOffSet: -0.2, //this
        endYOffSet: 0.08,
        imageHeight: 90,
        imageWidth: 90,
        alignment: Alignment.topLeft),
  ];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animationController!.repeat().whenComplete(() {});
  }

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const TherapistsListScreen(),
      ));
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: GradientBackgroundWidget(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomPaint(
                        size: Size(
                            deviceWidth(context),
                            (deviceHeight(context) * 0.30)
                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: QuestionScreenCustomPainter(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.logo,
                              height: deviceHeight(context) * 0.12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    child: Column(
                      children: [
                        ToolBarWidget(
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        heightGap(10),
                        const Center(
                          child: SizedBox(
                            width: 250,
                            child: TextWidget(
                              text: 'We match you with licensed therapists...',
                              textAlign: TextAlign.center,
                              fontSize: 22,
                              color: AppColors.white,
                              fontFamily: AppFonts.poppins,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* SizedBox(
                    width: double.infinity,
                    height: deviceHeight(context) * 0.57,
                    child: Image.asset(
                      AppImages.thfGif,
                      fit: BoxFit.fitWidth,
                    ),
                  ),*/
                  SizedBox(
                    height: deviceHeight(context) * 0.60,
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.loose,
                      children: <Widget>[
                        // left = x value, top = y value;
                        // to set last position (50,10) top:50, left:10, end _animation Offset.zero

                        ...list.map(
                          (e) => Positioned(
                            top: e.top,
                            left: e.left,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                      begin: Offset(e.beginXOffSet ?? 0,
                                          e.beginYOffSet ?? 0),
                                      end: Offset(
                                          e.endXOffSet ?? 0, e.endYOffSet ?? 0))
                                  .animate(
                                CurvedAnimation(
                                    parent: _animationController!,
                                    curve: Curves.easeOutQuad),
                              ),
                              child: AnimatedContainer(
                                //color: Colors.amber,
                                padding: EdgeInsets.zero,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                alignment: e.alignment,
                                duration: const Duration(seconds: 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image(
                                    height: e.imageHeight,
                                    width: e.imageWidth,
                                    fit: BoxFit.cover,
                                    image: AssetImage(e.image ?? ''),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
