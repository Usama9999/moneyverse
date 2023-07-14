import 'dart:collection';

import 'package:get/get.dart';
import 'package:talentogram/controllers/post_controller.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/models/post_model.dart';
import 'package:talentogram/respositories/post_repo.dart';
class ViewPostController extends GetxController {
  bool loading = false;
  bool isPostAvailable = true;
  List<PostModel> postModel = [];
  Future<void> getPosts(int postId) async {
    loading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['postId'] = postId;

    var categories = await PostRepo().getPosts(requestParams);

    categories.fold((failure) {
      _errorDialogue(failure);
      loading = false;
      isPostAvailable = false;
      update();
    }, (mResult) {
      postModel = mResult.responseData as List<PostModel>;
      if (postModel.isEmpty) {
        isPostAvailable = false;
      }
      loading = false;
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
