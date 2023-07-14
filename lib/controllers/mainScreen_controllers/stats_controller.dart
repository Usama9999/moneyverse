import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/respositories/user_repo.dart';

import '../../utils/app_colors.dart';

class MyStatsController extends GetxController {
  bool loading = false;
  Map response = {
    "userMeta": {
      "balance": 0,
      "earnings": 0,
    },
    "stats": {"total": 0, "wins": 0}
  };
  var dataMap = <String, double>{
    "JOINED": 0,
    "WINS": 0,
    "RESULT PENDING": 0,
  };

  final colorList = <Color>[
    AppColors.sparkliteblue,
    Colors.greenAccent,
    AppColors.lightPurple,
  ];
  Future<void> getMyStats() async {
    loading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var signInEmail = await UserRepo().getMyStats(requestParams);
    loading = false;
    update();
    signInEmail.fold((failure) {}, (mResult) {
      response = mResult.responseData as Map;
      dataMap['JOINED'] = double.parse(response['stats']['total'].toString());
      dataMap['WINS'] = double.parse(response['stats']['wins'].toString());
      dataMap['RESULT PENDING'] = double.parse(
          (response['stats']['total'] - response['stats']['wins']).toString());
      log(dataMap['RESULT PENDING'].toString());
      update();
    });
  }
}
