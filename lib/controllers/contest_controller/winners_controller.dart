import 'dart:async';
import 'dart:collection';

import 'package:get/get.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/respositories/contest_repo.dart';

class WinnerController extends GetxController {
  List<ContestModel> contests = [];
  bool winnerLoading = false;

  ///////////////////////////////////
  ///
  /// Home screen work
  ///////////////////////////////////

  bool contestLoader = false;
  Future<void> getPreviousContests() async {
    contestLoader = true;
    contests.clear();
    update();
    HashMap<String, Object> requestParams = HashMap();

    var contestRes = await ContestRepo().getPreviousContest(requestParams);

    contestRes.fold((failure) {
      _errorDialogue(failure);
      contestLoader = false;
      update();
    }, (mResult) {
      contests = mResult.responseData as List<ContestModel>;
      contestLoader = false;
      update();
    });
  }

  ///////////////////////////////////
  ///
  /// Home screen work
  ///////////////////////////////////
  bool winnerDetailsLoader = false;
  Map winnerDetails = {};
  bool error = false;
  Future<void> getWinnerDetails(int userId, int contestId, String type) async {
    winnerDetailsLoader = true;
    error = false;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['userId'] = userId;
    requestParams['contestId'] = contestId;
    requestParams['type'] = type;
    var contestRes = await ContestRepo().getWinnerDetails(requestParams);

    contestRes.fold((failure) {
      error = true;
      winnerDetailsLoader = false;
      update();
    }, (mResult) {
      List data = mResult.responseData as List;
      if (data.isNotEmpty) {
        winnerDetails = data.first;
        print(winnerDetails);
      }
      winnerDetailsLoader = false;
      update();
    });
  }
  ///////////////////////////////////
  ///
  /// Particiapating
  ///////////////////////////////////

  void _errorDialogue(Failure failure) {
    Global.showToastAlert(
        strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
  }
}
