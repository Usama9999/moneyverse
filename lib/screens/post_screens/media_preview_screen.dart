import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/create_post_controller.dart';
import 'package:talentogram/globals/components/contest_components/tiktok_video_view.dart';
import 'package:talentogram/screens/post_screens/camera_screen.dart';

class MediaPreviewScreen extends StatefulWidget {
  final String filePath;
  final bool isVideo;
  const MediaPreviewScreen(
      {super.key, required this.filePath, this.isVideo = false});

  @override
  State<MediaPreviewScreen> createState() => _MediaPreviewScreenState();
}

class _MediaPreviewScreenState extends State<MediaPreviewScreen> {
  var controller = Get.put(CreatePostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: widget.isVideo
                  ? VideoView(isLocal: true, url: widget.filePath)
                  : Image.file(File(widget.filePath))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () async {
                      Get.off(() => CameraScreen(
                          cameras: Get.find<CreatePostController>().cameras));
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      size: 35,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      if (widget.isVideo) {
                        controller.selectVideo(XFile(widget.filePath));
                        Get.back();
                      } else {
                        controller.selectImage(XFile(widget.filePath));
                        Get.back();
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      size: 35,
                      color: Colors.white,
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }
}
