import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/local_chat_model.dart';

import '../../models/chat_model.dart';
import '../../globals/services/database.dart';

class ChatDetailController extends GetxController {
  bool mShowData = false;
  bool isShowLoader = false;
  bool isShowEmojis = false;
  // late io.Socket socket;
  List<LocalChatModel> alChat = [];
  int initialCount = 0;
  TextEditingController controllerMessage = TextEditingController();

  bool showSendButton = false;

  String imgProfilePic = '';

  changeText(String strvalue) {
    if (Global.checkNull(strvalue) && strvalue.trim().isNotEmpty) {
      showSendButton = true;
    } else {
      showSendButton = false;
    }
    update();
  }

  sendMessage(String id, int userId) {
    if (controllerMessage.text.trim().isNotEmpty) {
      Database.addMessage(
          id,
          ChatModel(
              from: 86,
              to: userId,
              message: controllerMessage.text.trim(),
              files: [],
              timeStamp: Timestamp.now()));
    }

    controllerMessage.clear();
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
}
