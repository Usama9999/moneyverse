// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

class NotificationModel {
  int notificationId;
  String message;
  String title;
  dynamic toUser;
  String createdAt;
  String updatedAt;
  dynamic contestId;
  dynamic image;
  String type;

  NotificationModel({
    required this.notificationId,
    required this.message,
    required this.title,
    required this.toUser,
    required this.createdAt,
    required this.updatedAt,
    required this.contestId,
    required this.image,
    required this.type,
  });

  factory NotificationModel.fromJson(String str) =>
      NotificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        notificationId: json["notificationId"],
        title: json["title"],
        message: json["message"],
        toUser: json["toUser"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        contestId: json["contestId"],
        image: json["image"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "notificationId": notificationId,
        "message": message,
        "toUser": toUser,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "contestId": contestId,
        "image": image,
        "type": type,
      };

  String getIcon() {
    if (type == 'winner') {
      return 'ic_winner.png';
    } else if (type == 'deposit') {
      return 'ic_money.png';
    }
    return 'ic_announce.png';
  }

  bool get isWinner => type == 'winner';

  String getFormatedDate() {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(createdAt, true);
    var dateLocal = dateTime.toLocal();
    final DateFormat formatter = DateFormat("MMM dd, HH:mm a");
    final String formatted = formatter.format(dateLocal);
    return formatted;
  }
}
