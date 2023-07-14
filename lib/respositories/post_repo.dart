import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/models/post_comments.dart';
import 'package:talentogram/models/post_model.dart';
import 'package:talentogram/models/result.dart';
import 'package:talentogram/models/succes.dart';
import 'package:talentogram/globals/rest_api/request_listener.dart';

class PostRepo {
  Future<Either<Failure, Success>> getPosts(
      HashMap<String, Object> requestParams,
      {bool isContent = false}) async {
    try {
      String url = isContent ? 'contest/getContestPosts' : 'posts/';
      String response = await ReqListener.fetchPost(
          strUrl: url,
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse =
          Result(responseStatus: true, responseMessage: 'Success');
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse!.responseStatus == true) {
        List<PostModel> posts = [];
        List result = mResponse.responseData as List;
        for (var post in result) {
          posts.add(PostModel.fromMap(post));
        }
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: posts,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getPostComments(
    HashMap<String, Object> requestParams,
  ) async {
    try {
      String url = 'posts/getPostComments';
      String response = await ReqListener.fetchPost(
          strUrl: url,
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse =
          Result(responseStatus: true, responseMessage: 'Success');
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse!.responseStatus == true) {
        List<PostComments> comments = [];
        List result = mResponse.responseData as List;
        for (var post in result) {
          comments.add(PostComments.fromMap(post));
        }
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: comments,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }

  Future<void> reactPost(
      HashMap<String, Object> requestParams, bool liked) async {
    await ReqListener.fetchPost(
        strUrl: liked ? 'posts/like' : 'posts/unLike',
        requestParams: requestParams,
        mReqType: ReqType.post,
        mParamType: ParamType.json);
  }

  Future<Either<Failure, Success>> commentPost(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'posts/comment';
      String response = await ReqListener.fetchPost(
          strUrl: url,
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse =
          Result(responseStatus: true, responseMessage: 'Success');
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse!.responseStatus == true) {
        Map result = mResponse.responseData as Map;
        int id = result['insertId'];
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: id,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }

  Future<void> deleteCommentPost(HashMap<String, Object> requestParams) async {
    await ReqListener.fetchPost(
        strUrl: 'posts/deletComment',
        requestParams: requestParams,
        mReqType: ReqType.post,
        mParamType: ParamType.json);
  }

  Future<Either<Failure, Success>> savePost(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'posts/save';
      String response = await ReqListener.fetchPost(
          strUrl: url,
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse =
          Result(responseStatus: true, responseMessage: 'Success');
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse!.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: '',
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
}
