import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/globals/rest_api/request_listener.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/models/notification_model.dart';
import 'package:talentogram/models/result.dart';
import 'package:talentogram/models/succes.dart';
import 'package:talentogram/models/transaction_mode.dart';

class UserRepo {
  Future<Either<Failure, Success>> getTransactions(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'transaction/';
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
        List<TransactionModel> transaction = [];
        List result = mResponse.responseData as List;
        transaction = result.map((e) => TransactionModel.fromMap(e)).toList();

        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: transaction,
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

  Future<Either<Failure, Success>> buyTokens(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'transaction/buyTokens';
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
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getMyData(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'users/myData';
      String response = await ReqListener.fetchPost(
          strUrl: url,
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.json);
      Result? mResponse =
          Result(responseStatus: true, responseMessage: 'Success');
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }
      List res = mResponse!.responseData as List;

      if (mResponse!.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: res.isEmpty ? {} : res[0],
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

  Future<Either<Failure, Success>> getNotifications(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'notification/';
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
        List<NotificationModel> notifications = [];
        List result = mResponse.responseData as List;
        for (var notification in result) {
          notifications.add(NotificationModel.fromMap(notification));
        }
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: notifications,
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

  Future<Either<Failure, Success>> changeEarningVisible(int status) async {
    try {
      HashMap<String, Object> requestParams = HashMap();
      requestParams['status'] = status;
      String url = 'users/changeEarningVisible';
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
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }

  Future<Either<Failure, Success>> addBankDetails(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'users/addBankDetails',
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse =
          Result(responseStatus: true, responseMessage: 'Success');
      if (response == 'internet') {
        return Left(Failure(
            DATA: "",
            MESSAGE: "Please check your internet connection",
            STATUS: false));
      }
      if (response.isNotEmpty) {
        mResponse = await Global.getData(response);
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

  Future<Either<Failure, Success>> getBankDetails(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'users/bankdetails',
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
      Result? mResponse =
          Result(responseStatus: true, responseMessage: 'Success');
      if (response == 'internet') {
        return Left(Failure(
            DATA: "",
            MESSAGE: "Please check your internet connection",
            STATUS: false));
      }
      if (response.isNotEmpty) {
        mResponse = await Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse!.responseStatus == true) {
        log(mResponse.responseMessage);

        List result = mResponse.responseData as List;

        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: result,
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

  Future<Either<Failure, Success>> getMyStats(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'users/myStats',
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
      Result? mResponse =
          Result(responseStatus: true, responseMessage: 'Success');
      if (response == 'internet') {
        return Left(Failure(
            DATA: "",
            MESSAGE: "Please check your internet connection",
            STATUS: false));
      }
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse!.responseStatus == true) {
        log(mResponse.responseMessage);

        Map result = mResponse.responseData as Map;

        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: result,
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
