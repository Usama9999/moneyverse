import 'dart:collection';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/respositories/contest_repo.dart';
import 'package:talentogram/respositories/create_post_repo.dart';
import 'package:video_compress/video_compress.dart';

import '../globals/enum.dart';
import '../globals/global.dart';

class CreatePostController extends GetxController {
  List<CameraDescription> cameras = <CameraDescription>[];
  TextEditingController descriptionCont = TextEditingController();
  FocusNode descfocusNode = FocusNode();

  RxBool isImageCovered = true.obs;

  XFile? imageFile;
  XFile? videoFile;
  TextEditingController controllerText = TextEditingController();

  bool isLoading = false;

  selectVideo(XFile file) {
    videoFile = file;
    update();
  }

  selectImage(XFile file) {
    imageFile = file;
    update();
  }

  unSelectAll() {
    imageFile = null;
    videoFile = null;
    update();
  }

  changeIsCovered() {
    isImageCovered(!isImageCovered.value);
    update();
  }

  getCameras() async {
    cameras = await availableCameras();
  }

  bool validation() {
    if (imageFile == null && videoFile == null) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please add a video/Image',
          toastType: TOAST_TYPE.toastError);
      return false;
    }

    return true;
  }

  Future<File> compressImage(File image, int quality, int percentage) async {
    var path = FlutterNativeImage.compressImage(image.absolute.path,
        quality: quality, percentage: percentage);
    return path;
  }

  createPost(ContestModel? contestModel) async {
    try {
      isLoading = true;
      update();
      if (validation()) {
        String videoPath = '';
        String thumbnailPath = '';
        String imagePath = '';
        if (videoFile != null) {
          videoPath = videoFile!.path;
          File thumbnailFile =
              await VideoCompress.getFileThumbnail(videoFile!.path);
          File compressedThumnail = await compressImage(thumbnailFile, 40, 20);
          thumbnailPath = compressedThumnail.path;
        }
        if (imageFile != null) {
          File image = await compressImage(File(imageFile!.path), 80, 70);
          imagePath = image.path;
          File th = await compressImage(File(imageFile!.path), 40, 30);
          thumbnailPath = th.path;
        }

        HashMap<String, String> requestParams = HashMap();
        HashMap<String, String> requestParamsMedia = HashMap();
        if (contestModel != null) {
          requestParams['contestId'] = contestModel.contestId.toString();
        }
        requestParams['coverImage'] = isImageCovered.value ? '1' : '0';
        requestParams['description'] = descriptionCont.text;

        if (imagePath != '') {
          requestParamsMedia['imageLink'] = imagePath;
          requestParamsMedia['thumbnail'] = thumbnailPath;
        }
        if (videoPath != '') {
          requestParamsMedia['videoLink'] = videoPath;
          requestParamsMedia['thumbnail'] = thumbnailPath;
        }

        var create = await CreatePostRepo()
            .createPost(requestParams, requestParamsMedia);
        // isShowLoader = false;
        // update();
        create.fold((failure) {
          Global.showToastAlert(
              context: Get.overlayContext!,
              strTitle: "",
              strMsg: failure.MESSAGE,
              toastType: TOAST_TYPE.toastError);
          isLoading = false;
          update();
        }, (mResult) {
          participated = true;
          isLoading = false;
          imageFile = null;
          videoFile == null;
          descriptionCont.clear();
          update();
        });
      }
    } catch (e) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: e.toString(),
          toastType: TOAST_TYPE.toastError);
      isLoading = false;
      update();
    }
  }

  bool participated = false;
  resetValues() {
    participated = false;
    isLoading = false;
    update();
  }

  Future<void> isParticipated(ContestModel contest) async {
    participated = false;
    isLoading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    requestParams['contestId'] = contest.contestId;

    var res = await ContestRepo().isParticipated(requestParams);

    res.fold((failure) {
      isLoading = false;
      update();
    }, (mResult) {
      isLoading = false;
      participated = mResult.responseData as bool;
      update();
    });
  }

  @override
  void onInit() {
    getCameras();
    super.onInit();
  }
}
