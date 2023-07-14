import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/models/result.dart';
import 'package:talentogram/models/succes.dart';
import 'package:talentogram/globals/rest_api/request_listener_multipart.dart';

class CreatePostRepo {
  Future<Either<Failure, Success>> createPost(
      HashMap<String, String> requestParams,
      HashMap<String, String> requestParamsM) async {
    try {
      String response = await ReqListenerMultiPart.fetchPost(
        strUrl: 'posts/create',
        requestParams: requestParams,
        mReqType: ReqType.post,
        requestParamsImages: requestParamsM,
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
        log(mResponse.responseMessage);
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: {},
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
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
