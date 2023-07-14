import 'dart:collection';

import 'package:get/get.dart';
import 'package:talentogram/globals/components/custom_alert.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/models/quiz_questions.dart';
import 'package:talentogram/respositories/contest_repo.dart';

class QuizQuestionsController extends GetxController {
  bool isLoading = false;
  bool participated = false;

  List<QuizQuestions> basicQuestion = [];

  List<Map> response = [];

  loading() {
    isLoading = !isLoading;
    update();
  }

  int correct = 0;

  validation() {
    correct = 0;
    response.clear();
    for (int i = 0; i < basicQuestion.length; i++) {
      if (basicQuestion[i].answerCont.text == basicQuestion[i].answer) {
        correct++;
      }
      response.add({
        "title": basicQuestion[i].title,
        'answer': basicQuestion[i].answer,
        'response': basicQuestion[i].answerCont.text,
        'options': basicQuestion[i].answersOptions,
      });
    }
  }

  addResponse(int contestId) async {
    validation();
    isLoading = true;
    update();

    HashMap<String, Object> requestParams = HashMap();
    requestParams['response'] = response;
    requestParams['contestId'] = contestId;
    requestParams['correct'] = correct;
    requestParams['total'] = basicQuestion.length;

    var signInEmail = await ContestRepo().setBasicResponse(requestParams);

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

  getQuestions(ContestModel contest) async {
    isLoading = true;
    participated = false;
    update();

    HashMap<String, Object> requestParams = HashMap();
    requestParams['contestId'] = contest.contestId;
    var signInEmail = await ContestRepo().getQuizQuestions(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      isLoading = false;
      update();
    }, (mResult) {
      Map res = mResult.responseData as Map;
      basicQuestion = res['questions'] as List<QuizQuestions>;
      participated = res['participated'] as bool;
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
