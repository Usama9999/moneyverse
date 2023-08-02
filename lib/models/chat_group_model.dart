// To parse this JSON data, do
//
//     final chatGroupModel = chatGroupModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatGroupModel {
  ChatGroupModel({
    required this.users,
    required this.roomId,
    required this.lastMessage,
    required this.user1,
    required this.user2,
    required this.timestamp,
    required this.unreadCount,
    required this.lastMessageBy,
  });

  List users;
  String roomId;
  int unreadCount;

  int lastMessageBy;
  String lastMessage;
  GroupChatUser user1;
  GroupChatUser user2;
  Timestamp timestamp;

  factory ChatGroupModel.fromMap(DocumentSnapshot json) => ChatGroupModel(
        roomId: json.id,
        users: json["users"],
        lastMessageBy: json["lastMessageBy"],
        unreadCount: json["unreadCount"],
        lastMessage: json["lastMessage"],
        user1: GroupChatUser.fromMap(json["user1"]),
        user2: GroupChatUser.fromMap(json["user2"]),
        timestamp: json["timestamp"],
      );
}

class GroupChatUser {
  GroupChatUser({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory GroupChatUser.fromJson(String str) =>
      GroupChatUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupChatUser.fromMap(Map<String, dynamic> json) => GroupChatUser(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
