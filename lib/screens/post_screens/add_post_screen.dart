import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/create_post_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/components/contest_components/tiktok_video_view.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/custom_text_fields.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/screens/post_screens/camera_screen.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class AddPostScreen extends StatefulWidget {
  final ContestModel? contest;
  const AddPostScreen({super.key, this.contest});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var controller = Get.put(CreatePostController());

  @override
  void initState() {
    controller.participated = false;
    controller.isLoading = false;
    if (widget.contest != null) {
      Future.delayed(Duration.zero, () {
        controller.isParticipated(widget.contest!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 2.0),
          activeTrackColor: Colors.black,
          inactiveTrackColor: Colors.grey,
          trackHeight: 3,
          thumbColor: Colors.white),
      child: LayoutBuilder(builder: (context, size) {
        return Scaffold(
          appBar: customAppBar('', isCentered: true),
          body: Stack(
            children: [
              ListView(
                padding: EdgeInsets.symmetric(horizontal: wd(15)),
                children: [
                  Text(
                    widget.contest == null
                        ? 'Post of the Week Contest'
                        : 'Create Post',
                    style: subHeadingText(size: 25, color: AppColors.textGrey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<CreatePostController>(builder: (controller) {
                    if (controller.imageFile == null &&
                        controller.videoFile == null) {
                      return _addVideo(size);
                    }

                    if (controller.imageFile != null) {
                      return _imageSection(size);
                    }
                    if (controller.videoFile != null) {
                      return _videoSection(size);
                    }

                    return Container(
                      height: 260,
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Description',
                      style: subHeadingText(),
                    ),
                  ),
                  customTextFiledMultiLine(
                      controller.descriptionCont, controller.descfocusNode,
                      lines: 4, hint: 'Description'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      label: 'Participate',
                      onPress: () {
                        controller.createPost(widget.contest);
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
              GetBuilder<CreatePostController>(builder: (value) {
                return AppViews.loadingScreen(value.isLoading);
              }),
              GetBuilder<CreatePostController>(builder: (value) {
                return AppViews.showGif(value.participated, 'api',
                    text: widget.contest == null
                        ? 'Post created successfully'
                        : 'You have already participated in this contest');
              })
            ],
          ),
        );
      }),
    );
  }

  Container _addVideo(BoxConstraints size) {
    return Container(
        height: size.maxWidth,
        width: size.maxWidth,
        decoration: ContainerProperties.shadowDecoration(radius: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/ic_dots.png",
                  height: size.maxWidth * 0.35,
                  // color: AppColors.sparkliteblue,
                ),
                Center(
                    child: Image.asset(
                  "assets/images/upload 1.png",
                  height: size.maxWidth * 0.2,
                ))
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Material(
              child: InkWell(
                onTap: () {
                  Get.to(() => CameraScreen(
                        cameras: controller.cameras,
                      ));
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Container(
                    height: 40,
                    width: 170,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text('Add Video/Image', style: regularText()),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _imageSection(BoxConstraints size) {
    return Container(
      // alignment: Alignment.center,
      decoration: ContainerProperties.shadowDecoration(radius: 10),
      height: size.maxWidth,
      width: size.maxWidth,
      child: Stack(
        children: [
          Obx(
            () => SizedBox(
              height: size.maxWidth + 50,
              width: size.maxWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.file(
                  File(controller.imageFile!.path),
                  fit: controller.isImageCovered.value
                      ? BoxFit.cover
                      : BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  controller.unSelectAll();
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 12,
                  child: const FittedBox(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  controller.changeIsCovered();
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 14,
                  child: const FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(
                        CupertinoIcons.resize,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _videoSection(BoxConstraints size) {
    return Container(
      decoration: ContainerProperties.shadowDecoration(radius: 10),
      height: size.maxWidth + 50,
      width: size.maxWidth,
      child: Stack(
        children: [
          VideoView(
            isLocal: true,
            url: controller.videoFile!.path,
          ),
          Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  controller.unSelectAll();
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 12,
                  child: const FittedBox(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

extension ToHexa on Color {
  String toHexTriplet() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
