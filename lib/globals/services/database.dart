// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talentogram/models/chat_model.dart';
import 'package:talentogram/utils/login_details.dart';

class Database {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> isNewUser(String email) async {
    QuerySnapshot doc = await _firestore
        .collection("users")
        .where('email', isEqualTo: email)
        .get();
    return doc.docs.isEmpty;
  }

  static Future<String> createChatRoom(int otheruseId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('check',
              arrayContains: '${otheruseId}${Get.find<UserDetail>().userId}')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs[0].id;
      }
      DocumentReference df = await _firestore.collection('chats').add({
        'users': [Get.find<UserDetail>().userId, otheruseId],
        'lastMessage': "",
        'lastMessageBy': Get.find<UserDetail>().userId,
        'user1': Get.find<UserDetail>().userId,
        'user2': Get.find<UserDetail>().userId,
        'check': [
          '${otheruseId}${Get.find<UserDetail>().userId}',
          '${Get.find<UserDetail>().userId}${otheruseId}'
        ],
        'timestamp': Timestamp.now()
      });
      return df.id;
    } catch (e) {
      debugPrint(e.toString());
      return 'null';
    }
  }

  static Future<bool> addMessage(String docId, ChatModel chat) async {
    try {
      await _firestore
          .collection('chats')
          .doc(docId)
          .collection('messages')
          .add({
        "from": Get.find<UserDetail>().userId,
        "to": chat.to,
        "message": chat.message,
        "files": chat.files,
        "timestamp": chat.timeStamp,
      });
      await _firestore.collection('chats').doc(docId).update({
        'lastMessage': chat.message,
        'user1': {
          'id': Get.find<UserDetail>().userId,
          'name': Get.find<UserDetail>().name,
          'image': Get.find<UserDetail>().image
        },
        'timestamp': Timestamp.now()
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
