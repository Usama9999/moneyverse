import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/respositories/contest_repo.dart';
import 'package:talentogram/screens/contest_screens/count_down_screen.dart';
import 'package:talentogram/screens/contest_screens/puzzle/puzzle_contest.dart';
import 'package:talentogram/screens/contest_screens/quiz/quiz_contest.dart';

import '../../screens/post_screens/add_post_screen.dart';

class ContestManagerController extends GetxController {
  List<ContestModel> contests = [];
  bool contestLoading = false;

  ///////////////////////////////////
  ///
  /// Home screen work
  ///////////////////////////////////

  List<ContestModel> upcomingContest = [];
  List<ContestModel> ongoingContest = [];
  bool contestLoader = false;
  Future<void> getHomeContests() async {
    contestLoader = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var contestRes = await ContestRepo().getHomeContests(requestParams);

    contestRes.fold((failure) {
      _errorDialogue(failure);
      contestLoader = false;
      update();
    }, (mResult) {
      Map data = mResult.responseData as Map;
      upcomingContest = data['upcoming'];
      ongoingContest = data['ongoing'];
      contestLoader = false;
      update();
    });
  }
  ///////////////////////////////////
  ///
  /// Particiapating
  ///////////////////////////////////

  bool participateLoading = false;

  Future<void> participate(ContestModel contest) async {
    participateLoading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    requestParams['contestId'] = contest.contestId;
    requestParams['entryFee'] = contest.entryFee;

    var res = await ContestRepo().participate(requestParams);

    res.fold((failure) {
      _errorDialogue(failure);
      participateLoading = false;
      update();
    }, (mResult) {
      contest.participated = 1;
      contest.participents++;
      participateLoading = false;
      update();
      Global.showToastAlert(
          strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      Get.off(() => CountDownScreen(contest: contest));
    });
  }
  ///////////////////////////////////
  ///
  /// Count down screen
  ///////////////////////////////////

  bool timerLoading = false;
  DateTime datenow = DateTime.now();

  Timer? timer;

  calculateTime(ContestModel contest) async {
    timerLoading = true;
    update();

    DateTime? now = await getTime();
    if (now == null) {
      timerLoading = false;
      update();
      Get.back();
      return;
    }
    datenow = now.toLocal();
    log(datenow.toString());
    timerLoading = false;
    update();
    if (contest.getStartTime.compareTo(datenow) < 0) {
      if (contest.type == 'post') {
        Get.off(() => AddPostScreen(
              contest: contest,
            ));
      } else if (contest.type == 'quiz') {
        Get.off(() => QuizContest(
              contest: contest,
            ));
      } else {
        Get.off(() => PuzzleGame(
              contestModel: contest,
            ));
      }
    }
  }

  cancelTime() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  Future<DateTime?> getTime() async {
    HashMap<String, Object> requestParams = HashMap();
    var res = await ContestRepo().getTime(requestParams);

    return res.fold((failure) {
      return null;
    }, (mResult) {
      return mResult.responseData as DateTime;
    });
  }

  void _errorDialogue(Failure failure) {
    Global.showToastAlert(
        strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
  }
}
