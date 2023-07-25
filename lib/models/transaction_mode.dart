// To parse this JSON data, do
//
//     final transactionMode = transactionModeFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

class TransactionModel {
  int transactionId;
  int userId;
  int amount;
  String nature;
  String type;
  String createdAt;

  TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.amount,
    required this.nature,
    required this.type,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(String str) =>
      TransactionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromMap(Map<String, dynamic> json) =>
      TransactionModel(
        transactionId: json["transactionId"],
        userId: json["userId"],
        amount: json["amount"] ?? 0,
        nature: json["nature"] ?? "debit",
        type: json["type"] ?? "token",
        createdAt: json["createdAt"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "transactionId": transactionId,
        "userId": userId,
        "amount": amount,
        "nature": nature,
        "type": type,
        "createdAt": createdAt,
      };

  bool get isToken => type == 'token';
  bool get isDebit => nature == 'debit';
  String get getNature => nature == 'debit' ? 'DEBITED' : 'CREDITED';

  String getFormatedDate() {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(createdAt, true);
    var dateLocal = dateTime.toLocal();
    final DateFormat formatter = DateFormat("MMM dd , yyyy HH:mm a");
    final String formatted = formatter.format(dateLocal);
    return formatted;
  }
}
