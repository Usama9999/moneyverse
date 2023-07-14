// To parse this JSON data, do
//
//     final searchUser = searchUserFromMap(jsonString);

import 'dart:convert';

class SearchUser {
  SearchUser({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.userName,
  });

  int userId;
  String firstName;
  String lastName;
  String image;
  String userName;

  factory SearchUser.fromJson(String str) =>
      SearchUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchUser.fromMap(Map<String, dynamic> json) => SearchUser(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        image: json["image"] ?? '',
        userName: json["userName"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "image": image,
        "userName": userName,
      };
}
