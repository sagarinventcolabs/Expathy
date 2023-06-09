import 'dart:io';

import 'package:expathy/Common%20Widgets/text_widget.dart';
import 'package:expathy/Models/auth_model.dart';
import 'package:expathy/Utils/app_fonts.dart';
import 'package:expathy/Utils/app_strings.dart';
import 'package:expathy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Common Widgets/custom_scaffold.dart';
import '../../Common Widgets/elevated_button_widget.dart';
import '../../Common Widgets/text_form_field_widget.dart';
import '../../Custom Painter /auth_screen_painter.dart';
import '../../Providers/User Provider/user_provider.dart';
import '../../Remote/api_config.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_images.dart';
import '../../Utils/helper_methods.dart';
import '../../Widgets/skeleton_widget.dart';
import '../../Widgets/svg_picture.dart';
import '../../Widgets/toolbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final userNameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  bool isProfileUpdate = false;
  File? imageData;

  @override
  void initState() {
    /*userNameController.text = sharedPrefs?.getString(AppStrings.userName) ?? '';
    emailController.text = sharedPrefs?.getString(AppStrings.email) ?? '';*/
    context
        .read<UserProvider>()
        .getProfileApi(
          context: context,
        )
        .then((value) {
      userNameController.text = value?.data?.userName ?? '';
      emailController.text = value?.data?.email ?? '';
      ageController.text = value?.data?.age.toString() ?? '';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    return CustomScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              /*const SvgPic(
                image: AppImages.signUpHeader,
              ),*/
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
                              top: 32.0, right: 16, left: 16),
                          child: SingleChildScrollView(
                            child: Consumer<UserProvider>(
                              builder: (context, value, child) {
                                return value.profileLoading
                                    ? loadingShimmer()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Center(
                                            child: TextWidget(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .personalDetails,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: AppFonts.poppins),
                                          ),
                                          heightGap(20),
                                          Center(
                                            child: value.profileImageUploading
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .borderColor)),
                                                    width: 75,
                                                    height: 75,
                                                    child: const Center(
                                                        child:
                                                            CupertinoActivityIndicator()))
                                                : Stack(
                                                    children: [
                                                      circleImage(
                                                          url:
                                                              '$IMAGE_URL${value.profileImageUrl ?? ''}'),
                                                      Positioned(
                                                        right: 0,
                                                        bottom: 0,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await _showBottomSheet(
                                                                context:
                                                                    context,
                                                                userProvider:
                                                                    userProvider);
                                                          },
                                                          child: Container(
                                                            width: 28,
                                                            height: 28,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .yellow,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100)),
                                                            child: const Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          heightGap(28),
                                          TextFormFieldWidget(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .userName,
                                            controller: userNameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter user name';
                                              }
                                              return null;
                                            },
                                          ),
                                          heightGap(16),
                                          TextFormFieldWidget(
                                            hintText: 'age',
                                            controller: ageController,
                                          ),
                                          heightGap(16),
                                          TextFormFieldWidget(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .email,
                                            controller: emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            enabled: false,
                                          ),
                                          heightGap(32),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    deviceWidth(context) *
                                                        0.10),
                                            child: isProfileUpdate
                                                ? const Center(
                                                    child:
                                                        CupertinoActivityIndicator(),
                                                  )
                                                : ElevatedButtonWidget(
                                                    onPressed: () {
                                                      callUpdateProfileApi(
                                                          userProvider:
                                                              userProvider);
                                                    },
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .save,
                                                  ),
                                          ),
                                          heightGap(20),
                                        ],
                                      );
                              },
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

  Future<void> _showBottomSheet({
    BuildContext? context,
    UserProvider? userProvider,
  }) async {
    await showModalBottomSheet(
        context: context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext c) {
          return Padding(
            padding: MediaQuery.of(c).viewInsets,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () async {
                      await pickMedia(source: ImageSource.gallery)
                          .then((value) {
                        userProvider?.imageUploadApi(
                            context: context, file: imageData!);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () async {
                      await pickMedia(source: ImageSource.camera).then((value) {
                        userProvider?.imageUploadApi(
                            context: context, file: imageData!);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickMedia({
    required ImageSource source,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 50,
      maxHeight: 480,
      maxWidth: 640,
    );
    if (image != null) {
      imageData = File(image.path);
    }
  }

  Widget loadingShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightGap(20),
        ListView.separated(
          itemCount: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return shimmerEffect(
              widget: const SkeletonWidget(
                radius: 8,
                height: 45,
                width: double.infinity,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return heightGap(10);
          },
        ),
      ],
    );
  }

  Future<void> callUpdateProfileApi({UserProvider? userProvider}) async {
    setState(() {
      isProfileUpdate = true;
    });
    await context.read<UserProvider>().updateProfileApi(
          userName: userNameController.text.trim(),
          isFromEditProfileScreen: true,
          profilePic: userProvider?.profileImageUrl,
          age: ageController.text,
          context: context,
        );
    setState(() {
      isProfileUpdate = false;
    });
  }
}
