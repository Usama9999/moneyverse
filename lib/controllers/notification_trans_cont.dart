import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talentogram/models/notification_model.dart';
import 'package:talentogram/models/transaction_mode.dart';
import 'package:talentogram/respositories/user_repo.dart';

class NotTransController extends GetxController {
  bool loading = false;

  List<TransactionModel> transactions = [];
  List<NotificationModel> notifications = [];

  TextEditingController controllerSearch = TextEditingController();

  FocusNode focusNodeSearch = FocusNode();

  Future<void> getTransactions() async {
    loading = false;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var categories = await UserRepo().getTransactions(requestParams);

    categories.fold((failure) {
      // Global.errorDialogue(failure);
      loading = false;
      update();
    }, (mResult) {
      transactions = mResult.responseData as List<TransactionModel>;
      loading = false;
      update();
    });
  }

  Future<void> getNotification() async {
    loading = false;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var categories = await UserRepo().getNotifications(requestParams);

    categories.fold((failure) {
      // Global.errorDialogue(failure);
      loading = false;
      update();
    }, (mResult) {
      notifications = mResult.responseData as List<NotificationModel>;
      loading = false;
      update();
    });
  }
}
