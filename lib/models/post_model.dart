// To parse this JSON data, do
//
//     final postModel = postModelFromMap(jsonString);

import 'dart:convert';

class PostModel {
  PostModel({
    required this.postId,
    required this.userId,
    required this.description,
    required this.imageLink,
    required this.videoLink,
    required this.userImage,
    required this.firstName,
    required this.lastName,
    required this.coverImage,
    required this.liked,
  });

  int postId;
  int userId;
  int coverImage;
  int? liked;
  String description;
  String imageLink;
  String videoLink;
  dynamic userImage;
  String firstName;
  String lastName;

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        postId: json["postId"],
        userId: json["userId"],
        coverImage: json["coverImage"],
        liked: json["likedByMe"],
        description: json["description"] ?? '',
        imageLink: json["imageLink"] ?? "",
        videoLink: json["videoLink"] ?? '',
        userImage: json["userImage"] ?? '',
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "postId": postId,
        "userId": userId,
        "description": description,
        "imageLink": imageLink,
        "videoLink": videoLink,
        "userImage": userImage,
        "firstName": firstName,
        "lastName": lastName,
      };

  bool get isVideoPost => videoLink != '';
  bool get isImagePost => imageLink != '';
  bool get likedByMe => liked != null;
  bool get isCover => coverImage == 1;
}
