// To parse this JSON data, do
//
//     final contestTypeMode = contestTypeModeFromMap(jsonString);

import 'dart:convert';

class ContestTypeModel {
  ContestTypeModel({
    required this.id,
    required this.discription,
    required this.createdAt,
    required this.updatedAt,
    required this.active,
    required this.hours,
    required this.minutes,
    required this.days,
  });

  int id;
  String discription;
  String createdAt;
  String updatedAt;
  int active;
  int hours;
  int minutes;
  int days;

  factory ContestTypeModel.fromJson(String str) =>
      ContestTypeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContestTypeModel.fromMap(Map<String, dynamic> json) =>
      ContestTypeModel(
        id: json["id"],
        discription: json["discription"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        active: json["active"] ?? 0,
        hours: json["hours"] ?? 0,
        minutes: json["minutes"] ?? 0,
        days: json["days"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "discription": discription,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "active": active,
        "hours": hours,
        "minutes": minutes,
        "days": days,
      };
}
