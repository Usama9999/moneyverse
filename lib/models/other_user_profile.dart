// To parse this JSON data, do
//
//     final otherUserProfile = otherUserProfileFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class OtherUserProfile {
  final UserDetails userDetails;
  final Stats stats;

  OtherUserProfile({
    required this.userDetails,
    required this.stats,
  });

  factory OtherUserProfile.fromJson(String str) =>
      OtherUserProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtherUserProfile.fromMap(Map<dynamic, dynamic> json) =>
      OtherUserProfile(
        userDetails: UserDetails.fromMap(json["userDetails"]),
        stats: Stats.fromMap(json["stats"]),
      );

  Map<String, dynamic> toMap() => {
        "userDetails": userDetails.toMap(),
        "stats": stats.toMap(),
      };
}

class Stats {
  final int total;
  final int wins;

  Stats({
    required this.total,
    required this.wins,
  });

  factory Stats.fromJson(String str) => Stats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stats.fromMap(Map<String, dynamic> json) => Stats(
        total: json["total"],
        wins: json["wins"],
      );

  Map<String, dynamic> toMap() => {
        "total": total,
        "wins": wins,
      };
}

class UserDetails {
  final int userId;
  final int earnings;
  final int earningVisibility;
  final String firstName;
  final String lastName;
  final String email;
  final int isUserVerified;
  final int isEmailVerified;
  final String image;

  UserDetails({
    required this.userId,
    required this.earnings,
    required this.earningVisibility,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isUserVerified,
    required this.isEmailVerified,
    required this.image,
  });

  factory UserDetails.fromJson(String str) =>
      UserDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDetails.fromMap(Map<String, dynamic> json) => UserDetails(
        userId: json["userId"],
        earnings: json["earnings"],
        earningVisibility: json["earningVisibility"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        isUserVerified: json["isUserVerified"],
        isEmailVerified: json["isEmailVerified"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "earnings": earnings,
        "earningVisibility": earningVisibility,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "isUserVerified": isUserVerified,
        "isEmailVerified": isEmailVerified,
        "image": image,
      };

  bool get isVerified => isEmailVerified == 1;
  bool get earningHidden => earningVisibility == 0;
}
