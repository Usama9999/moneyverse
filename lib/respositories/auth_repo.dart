import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/globals/rest_api/request_listener.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/models/result.dart';
import 'package:talentogram/models/succes.dart';
import 'package:talentogram/utils/login_details.dart';

class AuthRepo {
  Future<Either<Failure, Success>> signup(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'users/create',
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
        Get.find<UserDetail>().setData(result);

        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: {},
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }
      if (mResponse.responseMessage.contains('Duplicate') &&
          mResponse.responseMessage.contains('email')) {
        mResponse.responseMessage = 'A user with this email already exists';
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

  Future<Either<Failure, Success>> newPassword(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'users/auth/changePassword',
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

  Future<Either<Failure, Success>> updatePassword(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'users/auth/updatePassword',
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

  saveData(Result mResponse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map result = mResponse.responseData as Map;
    String token = result['token'] ?? '';
    String image = result['user']['image'] ?? '';
    String email = result['user']['email'];
    String bio = result['user']['bio'] ?? '';
    String webiste = result['user']['website'] ?? '';
    String firstName = result['user']['firstName'];
    String lastName = result['user']['lastName'];
    int id = result['user']['userId'];
    String username = result['user']['userName'] ?? '';
    await sharedPreferences.setString(SharedPrefKey.KEY_ACCESS_TOKEN, token);
    if (firstName == lastName) {
      await sharedPreferences.setString('name', firstName);
    } else {
      await sharedPreferences.setString('name', '$firstName $lastName');
    }
    await sharedPreferences.setInt(SharedPrefKey.KEY_USER_ID, id);
    await sharedPreferences.setString(SharedPrefKey.KEY_USER_IMAGE, image);
    await sharedPreferences.setBool(SharedPrefKey.KEY_IS_LOGIN, true);
    await sharedPreferences.setString('userName', username);
    await sharedPreferences.setString('bio', bio);
    await sharedPreferences.setString('website', webiste);
    await sharedPreferences.setString('email', email);
    Get.find<UserDetail>().getData();
  }

  Future<Either<Failure, Success>> login(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'users/auth/login',
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
        log(mResponse.responseMessage);
        saveData(mResponse);

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

  Future<Either<Failure, Success>> sendEmailOtp(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'mail/verifyEmail';
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
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: result['otp'],
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

  Future<Either<Failure, Success>> forgetPassword(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'mail/forgorPassword';
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
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: result['otp'],
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

  Future<Either<Failure, Success>> changePassword(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'mail/verifyEmail';
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
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: result['otp'],
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
