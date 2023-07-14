import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/notification_model.dart';
import 'package:talentogram/respositories/user_repo.dart';

class ActivityScreenController extends GetxController {
  ShowData userLoading = ShowData.showData;

  List<NotificationModel> notification = [];

  TextEditingController controllerSearch = TextEditingController();

  FocusNode focusNodeSearch = FocusNode();

  Future<void> getNotification() async {
    userLoading = ShowData.showLoading;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var categories = await UserRepo().getNotifications(requestParams);

    categories.fold((failure) {
      Global.errorDialogue(failure);
      userLoading = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      notification = mResult.responseData as List<NotificationModel>;
      if (notification.isEmpty) {
        userLoading = ShowData.showNoDataFound;
      } else {
        userLoading = ShowData.showData;
      }
      update();
    });
  }
}
