// To parse this JSON data, do
//
//     final postComments = postCommentsFromMap(jsonString);

import 'dart:convert';

class PostComments {
  PostComments({
    required this.image,
    required this.firstname,
    required this.lastname,
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic image;
  String firstname;
  String lastname;
  int commentId;
  int postId;
  int userId;
  String comment;
  String createdAt;
  String updatedAt;

  factory PostComments.fromJson(String str) =>
      PostComments.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostComments.fromMap(Map<String, dynamic> json) => PostComments(
        image: json["image"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        commentId: json["commentId"],
        postId: json["postId"],
        userId: json["userId"],
        comment: json["comment"],
        createdAt: json["createdAt"] ?? 'T',
        updatedAt: json["updatedAt"] ?? 'T',
      );

  Map<String, dynamic> toMap() => {
        "image": image,
        "firstname": firstname,
        "lastname": lastname,
        "commentId": commentId,
        "postId": postId,
        "userId": userId,
        "comment": comment,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
