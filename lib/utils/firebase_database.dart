// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talentogram/models/chat_model.dart';
import 'package:talentogram/models/other_user_profile.dart';
import 'package:talentogram/utils/login_details.dart';

class FireDatabase {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Map> createChatRoom(UserDetails otheruser) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .where('check',
              arrayContains:
                  '${otheruser.userId}${Get.find<UserDetail>().userId}')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        if (querySnapshot.docs[0]['user1']['id'] ==
            Get.find<UserDetail>().userId) {
          return {
            'room': querySnapshot.docs[0].id,
            'id': querySnapshot.docs[0]['user2']['id'],
            'image': querySnapshot.docs[0]['user2']['image'],
            'name': querySnapshot.docs[0]['user2']['name'],
          };
        } else {
          return {
            'room': querySnapshot.docs[0].id,
            'id': querySnapshot.docs[0]['user1']['id'],
            'image': querySnapshot.docs[0]['user1']['image'],
            'name': querySnapshot.docs[0]['user1']['name'],
          };
        }
      }
      DocumentReference df = await _firestore.collection('chats').add({
        'users': [Get.find<UserDetail>().userId, otheruser.userId],
        'lastMessage': "",
        'lastMessageBy': Get.find<UserDetail>().userId,
        'unreadCount': 0,
        'user1': {
          'id': Get.find<UserDetail>().userId,
          'name': Get.find<UserDetail>().name,
          'image': Get.find<UserDetail>().image,
        },
        'user2': {
          'id': otheruser.userId,
          'image': otheruser.image,
          'name': "${otheruser.firstName} ${otheruser.lastName}",
        },
        'check': [
          '${otheruser.userId}${Get.find<UserDetail>().userId}',
          '${Get.find<UserDetail>().userId}${otheruser.userId}'
        ],
        'timestamp': Timestamp.now()
      });
      return {
        'room': df.id,
        'id': otheruser.userId,
        'image': otheruser.image,
        'name': "${otheruser.firstName} ${otheruser.lastName}",
      };
    } catch (e) {
      debugPrint(e.toString());
      return {};
    }
  }

  static Future<Map> createSupportRoom() async {
    try {
      // log('${supportId}${Get.find<UserDetail>().userId}');
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('supportChats')
          .where('check', arrayContains: '111${Get.find<UserDetail>().userId}')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return {
          'room': querySnapshot.docs[0].id,
          'id': querySnapshot.docs[0]['user2']['id'],
        };
      }
      DocumentReference df = await _firestore.collection('supportChats').add({
        'users': [111, Get.find<UserDetail>().userId],
        'lastMessage': "",
        'lastMessageBy': Get.find<UserDetail>().userId,
        'unreadCount': 0,
        'user1': {
          'id': Get.find<UserDetail>().userId,
          'name': Get.find<UserDetail>().name,
          'image': Get.find<UserDetail>().image,
        },
        'user2': {'id': 111},
        'check': [
          '111${Get.find<UserDetail>().userId}',
          '${Get.find<UserDetail>().userId}111'
        ],
        'timestamp': Timestamp.now()
      });

      return {
        'room': df.id,
        'id': 111,
      };
    } catch (e) {
      debugPrint(e.toString());
      return {};
    }
  }

  static Future<bool> addMessage(String docId, ChatModel chat) async {
    try {
      log(chat.to.isNegative.toString());
      await _firestore
          .collection(chat.to == 111 ? 'supportChats' : 'chats')
          .doc(docId)
          .collection('messages')
          .add({
        "from": Get.find<UserDetail>().userId,
        "to": chat.to,
        "message": chat.files.isNotEmpty && chat.message.isEmpty
            ? "Attachment"
            : chat.message,
        "files": chat.files,
        "timestamp": chat.timeStamp,
      });
      await _firestore
          .collection(chat.to.isNegative ? 'supportChats' : 'chats')
          .doc(docId)
          .update({
        'lastMessageBy': Get.find<UserDetail>().userId,
        'unreadCount': FieldValue.increment(1),
        'lastMessage': chat.message,
        'timestamp': Timestamp.now(),
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> updateWali(String docId, bool status) async {
    try {
      await _firestore.collection('chats').doc(docId).update({'wali': status});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> updateChaperon(String docId, bool status) async {
    try {
      await _firestore
          .collection('chats')
          .doc(docId)
          .update({'chaperon': status});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static setFirebaseUser() async {
    var token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<UserDetail>().userId.toString())
        .set({
      'online': true,
      'image': Get.find<UserDetail>().image,
      'name': Get.find<UserDetail>().name,
      'token': token ?? ''
    });
  }

  static Future<FirebaseUser> getFirebaseUser(int id) async {
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(id.toString())
        .get();
    if (doc.exists) {
      return FirebaseUser.fromMap(doc);
    } else {
      return FirebaseUser(name: 'User', image: '', token: '', gender: '');
    }
  }

  static changeUserAvailability(bool val) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<UserDetail>().userId.toString())
        .update({'online': val});
  }
}

class FirebaseUser {
  FirebaseUser(
      {required this.name,
      required this.image,
      required this.token,
      required this.gender});

  String name;
  String image;
  String gender;
  String token;

  factory FirebaseUser.fromMap(DocumentSnapshot json) => FirebaseUser(
        name: json["name"],
        image: json.get("image") ?? '',
        gender: json.get("gender") ?? '',
        token: '',
      );
}
