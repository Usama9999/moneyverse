// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

import 'dart:convert';

class NotificationModel {
  NotificationModel({
    required this.notificationId,
    required this.message,
    required this.fromUser,
    required this.toUser,
    required this.isFollowMessage,
    required this.userName,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.commentPost,
    required this.isAudioPost,
    required this.followedByMe,
    required this.isVideoPost,
    required this.likePost,
    required this.thumbnail,
  });

  int notificationId;
  String message;
  int fromUser;
  int toUser;
  int isFollowMessage;
  int? likePost;
  int? commentPost;
  int? followedByMe;
  int isVideoPost;
  int isAudioPost;
  String thumbnail;
  String userName;
  String image;
  String firstName;
  String lastName;

  factory NotificationModel.fromJson(String str) =>
      NotificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        notificationId: json["notificationId"],
        message: json["message"],
        fromUser: json["fromUser"],
        followedByMe: json["followedByMe"] ?? 0,
        thumbnail: json["thumbnail"] ?? '',
        toUser: json["toUser"],
        likePost: json["likePost"] ?? 0,
        commentPost: json["commentPost"],
        isVideoPost: json["isVideoPost"] ?? 0,
        isAudioPost: json["isAudioPost"] ?? 0,
        isFollowMessage: json["isFollowMessage"] ?? 0,
        userName: json["userName"] ?? "",
        image: json["image"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "notificationId": notificationId,
        "message": message,
        "fromUser": fromUser,
        "toUser": toUser,
        "isFollowMessage": isFollowMessage,
        "userName": userName,
        "image": image,
        "firstName": firstName,
        "lastName": lastName,
      };
}
