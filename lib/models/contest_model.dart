// To parse this JSON data, do
//
//     final contestModel = contestModelFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

class ContestModel {
  int contestId;
  String event;
  int active;
  String type;
  int winnerAnnounced;
  int entryFee;
  int totalPrize;
  int division;
  String startDate;
  List winners;
  String endDate;
  int participents;
  dynamic participated;

  ContestModel({
    required this.contestId,
    required this.event,
    required this.active,
    required this.type,
    required this.winnerAnnounced,
    required this.entryFee,
    required this.totalPrize,
    required this.division,
    required this.startDate,
    required this.endDate,
    required this.winners,
    required this.participents,
    required this.participated,
  });

  factory ContestModel.fromJson(String str) =>
      ContestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContestModel.fromMap(Map<String, dynamic> json) => ContestModel(
        contestId: json["contestId"],
        event: json["event"].toString().toUpperCase(),
        active: json["active"],
        type: json["type"],
        winnerAnnounced: json["winnerAnnounced"],
        entryFee: json["entryFee"],
        totalPrize: json["totalPrize"],
        division: json["division"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        winners: json["winners"] ?? [],
        participents: json["participents"] ?? 0,
        participated: json["participated"],
      );

  Map<String, dynamic> toMap() => {
        "contestId": contestId,
        "event": event,
        "active": active,
        "type": type,
        "winnerAnnounced": winnerAnnounced,
        "entryFee": entryFee,
        "totalPrize": totalPrize,
        "division": division,
        "startDate": startDate,
        "endDate": endDate,
        "participents": participents,
        "participated": participated,
      };

  bool get isWinnerAnnounced => winnerAnnounced == 1;
  bool get isJoined => participated != null;

  List<Winner> get winnerList =>
      winners.isEmpty ? [] : (winners).map((e) => Winner.fromMap(e)).toList()
        ..sort((a, b) => a.rank.compareTo(b.rank));

  DateTime get getStartTime {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(startDate, true);
    var dateLocal = dateTime.toLocal();
    return dateLocal;
  }

  DateTime converttoLocal(String dateUtc) {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(dateUtc, true);
    var dateLocal = dateTime.toLocal();
    return dateLocal;
  }

  String getDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  String getFormatedDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat("MMM dd , yyyy HH:mm a");
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  bool isToday(String dateTime) {
    DateTime serverDate = DateTime.parse(dateTime);
    DateTime serverUtc = DateTime.utc(serverDate.year, serverDate.month,
        serverDate.day, serverDate.hour, serverDate.minute);
    DateTime utc = DateTime.now().toUtc();

    return utc.isAfter(serverUtc);
  }

  String getTime(DateTime dateTime) {
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }
}

class Winner {
  int userId;
  String name;
  String image;
  int rank;

  Winner({
    required this.image,
    required this.name,
    required this.userId,
    required this.rank,
  });

  factory Winner.fromMap(Map<String, dynamic> json) => Winner(
        name: json['firstName'] + " " + json['lastName'],
        image: json['image'],
        userId: json['userId'],
        rank: json['position'] ?? 0,
      );
}
