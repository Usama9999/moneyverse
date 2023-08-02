import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talentogram/controllers/mainScreen_controllers/navbar_controller.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/respositories/auth_repo.dart';
import 'package:talentogram/respositories/profile_repo.dart';
import 'package:talentogram/respositories/user_repo.dart';
import 'package:talentogram/screens/main_screens/profile/bank_details_screen.dart';
import 'package:talentogram/screens/main_screens/profile/edit_profile.dart';
import 'package:talentogram/screens/main_screens/profile/email_otp.dart';
import 'package:talentogram/utils/login_details.dart';

class ProfileController extends GetxController {
  File? imageFile;
  bool loading = false;

  List<String> galleryImages = [];
  TextEditingController emailCont = TextEditingController();
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();

  void showImagePicker(context, {uploadGallery = false}) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Gallery'),
                    onTap: () async {
                      await imgFromGallery2(uploadGallery: uploadGallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    await imgFromCamera2(uploadGallery: uploadGallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  imgFromCamera2({uploadGallery = false}) async {
    try {
      ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      imageCompressor(pickedFile!);
    } catch (e) {
      print('image picker error: $e');
    }
  }

  imgFromGallery2({uploadGallery = false}) async {
    try {
      ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      imageCompressor(pickedFile!, uploadGallery: uploadGallery);
    } catch (e) {
      print('image picker error: $e');
    }
  }

  imageCompressor(XFile selectedImage, {uploadGallery = false}) async {
    try {
      if (uploadGallery) {
        loading = true;
        update();
      }
      File compressedFile = await FlutterNativeImage.compressImage(
          selectedImage.path,
          quality: 30,
          percentage: 50);
      imageFile = compressedFile;
      update();
    } catch (e) {
      Future.error(e);
      return;
    }
  }

  Future<void> updateProfile() async {
    loading = true;
    update();
    HashMap<String, String> requestParams = HashMap();
    HashMap<String, String> requestParamsImg = HashMap();

    if (imageFile != null) {
      requestParamsImg['image'] = imageFile!.path;
    }
    requestParams['firstName'] = firstNameCont.text;
    requestParams['lastName'] = lastNameCont.text;
    requestParams['image'] = Get.find<UserDetail>().image;

    var res =
        await ProfileRepo().updateProfile(requestParams, requestParamsImg);

    res.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      loading = false;
      update();
    }, (mResult) async {
      String img = mResult.responseData as String;
      await Get.find<UserDetail>()
          .updateProfile(img, firstNameCont.text, lastNameCont.text);
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      loading = false;
      update();
      Get.back();
    });
  }

  Future<int?> sendVerifyLink() async {
    if (loading) return null;
    int? otp;
    loading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var signInEmail = await AuthRepo().sendEmailOtp(requestParams);
    loading = false;
    update();
    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Something went wring. Please try again',
          toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      int code = mResult.responseData as int;
      Get.to(() => const EmailVerify(),
          arguments: {'code': code, 'screen': 'verify'});
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Code sent successfully!',
          toastType: TOAST_TYPE.toastSuccess);
      otp = code;
    });
    return otp;
  }

  Future<void> verifyUser() async {
    HashMap<String, Object> requestParams = HashMap();
    await ProfileRepo().verifyUser(requestParams);
  }

  bool profileLoading = false;

  Map userData = {"earnings": 0, "balance": 0, 'detailId': null};
  getCompletionStatus() async {
    profileLoading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    var res = await UserRepo().getMyData(requestParams);
    res.fold((failure) {}, (mResult) {
      profileLoading = false;
      userData = mResult.responseData as Map;
      update();
    });
  }

  int getComppletePrecentage() {
    if (userData['detailId'] == null && !Get.find<UserDetail>().isVerified) {
      return 10;
    } else if (userData['detailId'] == null ||
        !Get.find<UserDetail>().isVerified) {
      return 55;
    } else {
      return 100;
    }
  }

  void checkCompletion() {
    if (userData['detailId'] == null) {
      Get.find<NavBarController>().changeTab(0);
      Get.to(() => const BankDetailScreen());
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please provide your bank details.',
          toastType: TOAST_TYPE.toastInfo);
    } else if (!Get.find<UserDetail>().isEarningVisible) {
      Get.find<NavBarController>().changeTab(0);
      Get.to(() => const EditProfile());
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please verify your email.',
          toastType: TOAST_TYPE.toastInfo);
    }
  }
}
