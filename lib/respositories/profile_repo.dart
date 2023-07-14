import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/globals/rest_api/request_listener.dart';
import 'package:talentogram/globals/rest_api/request_listener_multipart.dart';
import 'package:talentogram/models/explore_user_model.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/models/post_model.dart';
import 'package:talentogram/models/result.dart';
import 'package:talentogram/models/succes.dart';

class ProfileRepo {
  Future<Either<Failure, Success>> getRelations(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'users/relations';
      String response = await ReqListener.fetchPost(
          strUrl: url,
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
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
            responseData: mResponse.responseData!,
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

  Future<Either<Failure, Success>> getPosts(
      HashMap<String, Object> requestParams, String isPrivate,
      {String isContest = '0'}) async {
    try {
      String url = 'posts/getMyPosts?privacy=$isPrivate&contest=$isContest';
      String response = await ReqListener.fetchPost(
          strUrl: url,
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
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
        int likes = 0;
        List result = mResponse.responseData as List;
        for (var post in result) {
          PostModel p = PostModel.fromMap(post);

          posts.add(p);
        }
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: {'posts': posts, 'likes': likes},
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
      return Left(Failure(STATUS: false, MESSAGE: e.toString(), DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getSaved(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'posts/getSavedPosts?userId=${requestParams['userId']}';
      String response = await ReqListener.fetchPost(
          strUrl: url,
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
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
          PostModel p = PostModel.fromMap(post);

          posts.add(p);
        }
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: {'posts': posts},
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
      return Left(Failure(STATUS: false, MESSAGE: e.toString(), DATA: ""));
    }
  }

  Future<Either<Failure, Success>> exploreUserPosts(
    HashMap<String, Object> requestParams,
  ) async {
    try {
      String url = 'posts/getOtherUserPosts';
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
          PostModel p = PostModel.fromMap(post);
          posts.add(p);
        }
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: {'posts': posts},
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
      return Left(Failure(STATUS: false, MESSAGE: e.toString(), DATA: ""));
    }
  }

  Future<Either<Failure, Success>> exploreUserProfile(
    HashMap<String, Object> requestParams,
  ) async {
    try {
      String url = 'users/getOtherUser';
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
        ExploreUserModel user = ExploreUserModel.fromMap(
            mResponse.responseData as Map<String, dynamic>);
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: user,
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
      return Left(Failure(STATUS: false, MESSAGE: e.toString(), DATA: ""));
    }
  }

  Future<Either<Failure, Success>> verifyUser(
    HashMap<String, Object> requestParams,
  ) async {
    try {
      String url = 'users/verify';
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
            responseData: {},
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
      return Left(Failure(STATUS: false, MESSAGE: e.toString(), DATA: ""));
    }
  }

  Future<Either<Failure, Success>> updateProfile(
    HashMap<String, String> requestParams,
    HashMap<String, String> requestParamsPart,
  ) async {
    try {
      String url = 'users/update';
      String response = await ReqListenerMultiPart.fetchPost(
        strUrl: url,
        requestParams: requestParams,
        mReqType: ReqType.post,
        requestParamsImages: requestParamsPart,
      );
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
        String url = result['url'];
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: url,
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
