import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/services/firebase_utils.dart';

class NavBarController extends GetxController {
  int currentIndex = 0;
  Widget currentPage = Container();
  PageType currentPageType = PageType.home;

  GlobalKey<ScaffoldState> key = GlobalKey();

  openDrawer() {
    key.currentState!.openDrawer();
  }

  changeTab(int index) {
    currentIndex = index;
    update();
  }

  onChangeBottomBar(int index) {
    update();
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }

  Future<bool> onWillPop() async {
    if (currentIndex == 0) {
      return showCustomAlertExitApp() ?? false;
    } else {
      changeTab(0);
      return false;
    }
  }

  showCustomAlertExitApp() {
    AppViews.showCustomAlert(
        context: Get.overlayContext!,
        strTitle: Constants.TEXT_EXIT,
        strMessage: Constants.TEXT_EXIT_MSG,
        strLeftBtnText: Constants.TEXT_NO,
        onTapLeftBtn: () {
          Get.back();
        },
        strRightBtnText: Constants.TEXT_YES,
        onTapRightBtn: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        });
  }

  @override
  void onInit() {
    FirebaseUtils.pushNotifications();
    super.onInit();
  }
}
