import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/post_controller.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/post_comments.dart';
import 'package:talentogram/respositories/post_repo.dart';
import 'package:talentogram/utils/login_details.dart';

import '../globals/enum.dart';

class PostCommentController extends GetxController {
  bool mShowData = false;
  bool isShowLoader = false;
  bool sendLoader = false;
  bool isShowEmojis = false;

  List<PostComments> comments = [];
  // late io.Socket socket;
  int initialCount = 0;
  TextEditingController controllerMessage = TextEditingController();

  bool showSendButton = false;

  resetController() {
    controllerMessage.clear();
    isShowEmojis = false;
    update();
  }

  addNewComment(int id) {
    comments.add(PostComments(
        image: Get.find<UserDetail>().image,
        firstname: Get.find<UserDetail>().name.split(' ')[0],
        lastname: Get.find<UserDetail>().name.split(' ')[1],
        commentId: id,
        postId: 32,
        userId: Get.find<UserDetail>().userId,
        comment: controllerMessage.text, 
        createdAt: 'Just Now',
        updatedAt: 'updatedAt'));
    resetController();
    update();
  }

  String imgProfilePic = '';

  changeText(String strvalue) {
    if (Global.checkNull(strvalue.trim())) {
      showSendButton = true;
    } else {
      showSendButton = false;
    }
    update();
  }

  addEmojis(String strvalue) {
    controllerMessage.text = controllerMessage.text + strvalue;
    showSendButton = true;
    update();
  }

  showEmoji() {
    isShowEmojis = isShowEmojis ? false : true;
    update();
  }

  disableEmoji() {
    isShowEmojis = false;

    update();
  }

  getPostComments(int postId) async {
    mShowData = true;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['postId'] = postId;

    var res = await PostRepo().getPostComments(requestParams);

    res.fold((failure) {
      
      mShowData = false;
      update();
    }, (mResult) {
      comments = mResult.responseData as List<PostComments>;
      mShowData = false;
      update();
    });
  }

  List<String> emojis = [
    '😀',
    '😃',
    '😄',
    '😁',
    '😅',
    '😂',
    '🤣',
    '🥲',
    '😊',
    '😇',
    '🙂',
    '🙃',
    '😉',
    '😌',
    '😍',
    '🥰',
    '😘',
    '😗',
    '😙',
    '😚'
  ];

  void deleteComment(PostComments comment) {
    comments.remove(comment);
    update();
  }

  void commentPost(int postId, int toUser) {
    sendLoader = true;
    update();
    Get.find<PostController>()
        .commentPost(postId, toUser, controllerMessage.text.trim())
        .then((id) {
      sendLoader = false;
      update();
      addNewComment(id);
    });
  }
}
