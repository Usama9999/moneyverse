import 'dart:collection';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:talentogram/models/post_model.dart';
import 'package:talentogram/respositories/post_repo.dart';

class PostController extends GetxController {
  reactPost(bool isLike, PostModel post) async {
    if (true) {
      HashMap<String, Object> requestParams = HashMap();
      requestParams['postId'] = post.postId;
      await PostRepo().reactPost(requestParams, isLike);
    }
  }

  Future<int> commentPost(int postId, int toUser, String comment) async {
    if (true) {
      HashMap<String, Object> requestParams = HashMap();
      requestParams['postId'] = postId;
      requestParams['comment'] = comment;

      var res = await PostRepo().commentPost(requestParams);
      int id = 0;
      res.fold((failure) {}, (mResult) {
        log('succes');
        id = mResult.responseData as int;
      });
      return id;
    }
  }

  Future<void> deleteComment(int commentId, int postId) async {
    HashMap<String, Object> requestParams = HashMap();
    requestParams['commentId'] = commentId;
    requestParams['postId'] = commentId;

    await PostRepo().deleteCommentPost(requestParams);
  }
}
