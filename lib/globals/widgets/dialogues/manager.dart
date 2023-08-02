import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/widgets/dialogues/info_dialogue.dart';

class DialogueManager {
  static void showInfoDialogue(String message) {
    showDialog(
        context: Get.overlayContext!,
        builder: (_) => InfoDialogue(
              message: message,
            ));
  }
}
