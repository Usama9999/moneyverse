import 'dart:collection';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/respositories/auth_repo.dart';
import 'package:talentogram/screens/main_screens/bottom_bar_screen.dart';

class SignUpController extends GetxController {
  bool isLoading = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController username = TextEditingController();

  FocusNode firstNameNode = FocusNode();
  FocusNode usernameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode focusNodeEmail = FocusNode();

  FocusNode focusNodePassword = FocusNode();

  TextEditingController controllerInvite = TextEditingController();

  FocusNode focusNodeInvite = FocusNode();
  bool validation() {
    if (!Global.checkNull(firstName.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'PLease enter first name',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(firstNameNode);
      return false;
    }
    if (!Global.checkNull(lastName.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'PLease enter last name',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(lastNameNode);
      return false;
    }

    if (!Global.checkNull(controllerEmail.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'PLease enter email',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(focusNodeEmail);
      return false;
    }
    if (!Global.checkNull(controllerPassword.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "ok",
          strMsg: 'PLease enter password',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(focusNodePassword);
      return false;
    }

    return true;
  }

  signupTask() async {
    String token = '';
    try {
      token = await FirebaseMessaging.instance.getToken() ?? '';
    } catch (e) {}
    try {
      if (validation()) {
        isLoading = true;
        update();
        HashMap<String, Object> requestParams = HashMap();
        requestParams['firstName'] = firstName.text.trim();
        requestParams['lastName'] = lastName.text.trim();
        requestParams['email'] = controllerEmail.text.trim();
        requestParams['invite'] = controllerInvite.text.trim();
        requestParams['firebaseToken'] = token;
        requestParams['password'] = controllerPassword.text.trim();

        var signInEmail = await AuthRepo().signup(requestParams);

        signInEmail.fold((failure) {
          Global.showToastAlert(
              context: Get.overlayContext!,
              strTitle: "",
              strMsg: failure.MESSAGE,
              toastType: TOAST_TYPE.toastError);
          isLoading = false;
          update();
        }, (mResult) {
          isLoading = false;
          update();
          Get.offAll(() => const NavBarScreen());
        });
      }
    } catch (e) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: "Could'nt sign up. Please try again.",
          toastType: TOAST_TYPE.toastInfo);
      isLoading = false;
      update();
    }
  }

  Future<void> createUser() async {
    if (!validation()) {
      return;
    }
    signupTask();
  }
}
