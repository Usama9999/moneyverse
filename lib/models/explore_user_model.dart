// To parse this JSON data, do
//
//     final exploreUserModel = exploreUserModelFromMap(jsonString);

import 'dart:convert';

class ExploreUserModel {
  ExploreUserModel({
    required this.user,
    required this.following,
    required this.followers,
  });

  List<User> user;
  List<Following> following;
  List<Follower> followers;

  factory ExploreUserModel.fromJson(String str) =>
      ExploreUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExploreUserModel.fromMap(Map<String, dynamic> json) =>
      ExploreUserModel(
        user: List<User>.from(json["user"].map((x) => User.fromMap(x))),
        following: List<Following>.from(
            json["following"].map((x) => Following.fromMap(x))),
        followers: List<Follower>.from(
            json["followers"].map((x) => Follower.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "user": List<dynamic>.from(user.map((x) => x.toMap())),
        "following": List<dynamic>.from(following.map((x) => x.toMap())),
        "followers": List<dynamic>.from(followers.map((x) => x.toMap())),
      };
}

class Follower {
  Follower({
    required this.followers,
  });

  int followers;

  factory Follower.fromJson(String str) => Follower.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Follower.fromMap(Map<String, dynamic> json) => Follower(
        followers: json["followers"],
      );

  Map<String, dynamic> toMap() => {
        "followers": followers,
      };
}

class Following {
  Following({
    required this.following,
  });

  int following;

  factory Following.fromJson(String str) => Following.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Following.fromMap(Map<String, dynamic> json) => Following(
        following: json["following"],
      );

  Map<String, dynamic> toMap() => {
        "following": following,
      };
}

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.userName,
    required this.followedByMe,
  });

  int userId;
  String firstName;
  String lastName;

  String image;
  String userName;

  dynamic followedByMe;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        image: json["image"],
        userName: json["userName"],
        followedByMe: json["followedByMe"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "image": image,
        "userName": userName,
        "followedByMe": followedByMe,
      };
}
