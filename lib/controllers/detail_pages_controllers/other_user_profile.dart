import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/models/other_user_profile.dart';
import 'package:talentogram/respositories/user_repo.dart';
import 'package:talentogram/utils/app_colors.dart';

class OtherUserProfileController extends GetxController {
  bool loading = true;
  bool error = false;
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
  late OtherUserProfile otherUserProfile;

  Future<void> getProifle(int id) async {
    loading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['userId'] = id;
    var profile = await UserRepo().getUserProfile(requestParams);
    profile.fold((failure) {
      error = true;
      loading = false;
      update();
    }, (mResult) {
      var response = mResult.responseData as Map;
      otherUserProfile = OtherUserProfile.fromMap(response);
      dataMap['JOINED'] = otherUserProfile.stats.total.toDouble();
      dataMap['WINS'] = otherUserProfile.stats.wins.toDouble();
      dataMap['RESULT PENDING'] =
          (otherUserProfile.stats.total - otherUserProfile.stats.wins)
              .toDouble();
      loading = false;
      update();
    });
  }
}
