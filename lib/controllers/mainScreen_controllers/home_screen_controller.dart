import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/contest_controller/contest_Manager_controller.dart';
import 'package:talentogram/controllers/post_controller.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/models/post_model.dart';
import 'package:talentogram/respositories/post_repo.dart';

class HomeScreenController extends GetxController {
  late PageController pageController;

  bool postLoader = true;
  bool talentoLoader = false;
  bool contestLoader = false;
  int currentPage = 0;
  bool isPaid = false;
  List<PostModel> foryouPosts = [];
  List<PostModel> talentoPosts = [];
  List<PostModel> contestPosts = [];

  ShowData getPostLoader = ShowData.showLoading;
  FeedType contestFeedType = FeedType.video;

  String getSelectedFeedType() {
    switch (contestFeedType) {
      case FeedType.audio:
        return 'Audio';
      case FeedType.writing:
        return 'Writing';
      case FeedType.video:
        return 'Video';
      case FeedType.photo:
        return 'Photo';
    }
  }

  Future<void> onRefresh() async {
    Future.wait(
        [getPosts(), Get.find<ContestManagerController>().getHomeContests()]);
  }

  Future<void> getPosts() async {
    postLoader = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var categories = await PostRepo().getPosts(requestParams);

    categories.fold((failure) {
      _errorDialogue(failure);
      postLoader = false;
      update();
    }, (mResult) {
      foryouPosts = mResult.responseData as List<PostModel>;
      if (foryouPosts.isEmpty) {
        Global.showToastAlert(
            context: Get.overlayContext!,
            strTitle: "",
            strMsg: 'No post to show',
            toastType: TOAST_TYPE.toastInfo);
      }
      postLoader = false;
      update();
    });
  }

  void _errorDialogue(Failure failure) {
    Global.showToastAlert(
        context: Get.overlayContext!,
        strTitle: "",
        strMsg: failure.MESSAGE,
        toastType: TOAST_TYPE.toastError);
  }

  void likePost(PostModel postModel) {
    if (postModel.likedByMe) {
      postModel.liked = null;
      update();
      Get.find<PostController>().reactPost(false, postModel);
    } else {
      postModel.liked = 0;
      update();
      Get.find<PostController>().reactPost(true, postModel);
    }
  }
}
