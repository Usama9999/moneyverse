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
  /// Particiapating
  ///////////////////////////////////

  void _errorDialogue(Failure failure) {
    Global.showToastAlert(
        strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
  }
}
