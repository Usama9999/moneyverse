import 'dart:collection';

import 'package:get/get.dart';
import 'package:talentogram/globals/components/custom_alert.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/models/quiz_questions.dart';
import 'package:talentogram/respositories/contest_repo.dart';

class GameContestController extends GetxController {
  bool isLoading = false;
  bool participated = false;

  List<QuizQuestions> basicQuestion = [];

  List<Map> response = [];

  loading() {
    isLoading = !isLoading;
    update();
  }

  int correct = 0;

  addResponse(int contestId) async {
    isLoading = true;
    update();

    HashMap<String, Object> requestParams = HashMap();

    requestParams['contestId'] = contestId;

    var signInEmail = await ContestRepo().setGameResponse(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(
          strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      isLoading = false;
      update();
    }, (mResult) {
      isLoading = false;
      participated = true;
      update();
    });
  }

  check(ContestModel contest) async {
    isLoading = true;
    participated = false;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['contestId'] = contest.contestId;
    var signInEmail = await ContestRepo().isParticipatedGame(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      isLoading = false;
      update();
    }, (mResult) {
      participated = mResult.responseData as bool;
      isLoading = false;
      update();
    });
  }

  showCustomAlertExit() {
    if (participated) {
      Get.back();
      return;
    }
    showCustomAlert(
        context: Get.overlayContext!,
        strTitle: "Exit",
        strMessage: 'Are you sure you want to exit?',
        strLeftBtnText: 'No',
        onTapLeftBtn: () {
          Get.back();
        },
        strRightBtnText: 'Yes',
        onTapRightBtn: () {
          Get.back();
          Get.back();
        });
  }
}
