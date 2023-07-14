import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/respositories/auth_repo.dart';

import '../../globals/global.dart';
import '../../screens/main_screens/profile/email_otp.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode oldpasswordNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  bool obscure = true;
  bool oldobscure = true;
  changeOldObscure() {
    oldobscure = !oldobscure;
    update();
  }

  changeObscure() {
    obscure = !obscure;
    update();
  }

  bool confirmObscure = true;
  changeObscureConfirm() {
    confirmObscure = !confirmObscure;
    update();
  }

  resestPassowrd() async {
    if (!Global.checkNull(emailController.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter email',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(emailNode);
      return false;
    }

    isLoading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['email'] = emailController.text.trim();
    var signInEmail = await AuthRepo().forgetPassword(requestParams);
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
      Get.off(() => const EmailVerify(),
          arguments: {'code': mResult.responseData as int, 'screen': 'forgot'});
    });
  }

  resetPassword() async {
    if (!(passwordController.text.contains(RegExp(r'[A-Z]')) &&
        passwordController.text.contains(RegExp(r'[0-9]')) &&
        passwordController.text.contains(RegExp(r'[a-z]')) &&
        passwordController.text.length > 7)) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "ok",
          strMsg:
              'Password must contain one upper case, one lower case, one number or symbol and it must be at least 8 characters long',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(passwordNode);
      return false;
    }
    if (!Global.checkNull(passwordController.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter password',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(passwordNode);
      return false;
    }
    if (!Global.checkNull(confirmPasswordController.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter confirm password',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(confirmPasswordNode);
      return false;
    }
    if (confirmPasswordController.text.toString().trim() !=
        passwordController.text.trim()) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: "Confirm password doesn’t match",
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(confirmPasswordNode);
      return false;
    }

    isLoading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['password'] = passwordController.text.trim();
    requestParams['email'] = emailController.text.trim();
    var signInEmail = await AuthRepo().newPassword(requestParams);
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
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Password changed successfully. Please login now',
          toastType: TOAST_TYPE.toastSuccess);
      Get.back();
    });
  }

  updatePassword() async {
    if (!Global.checkNull(oldpasswordController.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter old password',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(oldpasswordNode);
      return false;
    }
    if (!Global.checkNull(passwordController.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter password',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(passwordNode);
      return false;
    }
    if (!Global.checkNull(confirmPasswordController.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter confirm password',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(confirmPasswordNode);
      return false;
    }
    if (!(passwordController.text.contains(RegExp(r'[A-Z]')) &&
        passwordController.text.contains(RegExp(r'[0-9]')) &&
        passwordController.text.contains(RegExp(r'[a-z]')) &&
        passwordController.text.length > 7)) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "ok",
          strMsg:
              'Password must contain one upper case, one lower case, one number or symbol and it must be at least 8 characters long',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(passwordNode);
      return false;
    }
    if (confirmPasswordController.text.toString().trim() !=
        passwordController.text.trim()) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: "Confirm password doesn’t match",
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(confirmPasswordNode);
      return false;
    }

    isLoading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['password'] = passwordController.text.trim();
    requestParams['oldPassword'] = oldpasswordController.text.trim();
    var signInEmail = await AuthRepo().updatePassword(requestParams);
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
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Password changed successfully.',
          toastType: TOAST_TYPE.toastSuccess);
      Get.back();
    });
  }
}
