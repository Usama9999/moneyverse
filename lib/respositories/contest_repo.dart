import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/globals/rest_api/request_listener.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/models/failure.dart';
import 'package:talentogram/models/quiz_questions.dart';
import 'package:talentogram/models/result.dart';
import 'package:talentogram/models/succes.dart';

class ContestRepo {
  Future<Either<Failure, Success>> getContests(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'contest/getContests';
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
        List<ContestModel> contest = [];

        List result = mResponse.responseData as List;
        for (var post in result) {
          ContestModel p = ContestModel.fromMap(post);

          contest.add(p);
        }
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: contest,
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

  Future<Either<Failure, Success>> getTime(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'contest/currentTime';
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
        Map result = mResponse.responseData as Map;

        DateTime datetime =
            DateTime.parse(result['time'] ?? DateTime.now().toString());

        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: datetime,
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

  Future<Either<Failure, Success>> participate(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'contest/participate';
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

  Future<Either<Failure, Success>> isParticipatedGame(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'contest/isParticipatedGame';
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
        List data = mResponse.responseData as List;
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: data.isNotEmpty,
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

  Future<Either<Failure, Success>> isParticipated(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'contest/isParticipated';
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
        List data = mResponse.responseData as List;
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: data.isNotEmpty,
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

  Future<Either<Failure, Success>> getHomeContests(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'contest/getHomeContests';
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
        List<ContestModel> upcomingContest = [];
        List<ContestModel> ongoingContest = [];

        Map result = mResponse.responseData as Map;
        List upc = result['upcoming'] as List;
        List ong = result['ongoing'] as List;
        upcomingContest = upc.map((e) => ContestModel.fromMap(e)).toList();
        ongoingContest = ong.map((e) => ContestModel.fromMap(e)).toList();

        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: {
              'upcoming': upcomingContest,
              'ongoing': ongoingContest
            },
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

  Future<Either<Failure, Success>> getPreviousContest(
      HashMap<String, Object> requestParams) async {
    try {
      String url = 'contest/getPreviousContest';
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
        List<ContestModel> contests = [];

        List result = mResponse.responseData as List;

        contests = result.map((e) => ContestModel.fromMap(e)).toList();

        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: contests,
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

  Future<Either<Failure, Success>> getQuizQuestions(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'contest/getQuestions',
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
            Failure(DATA: "", MESSAGE: "No data found!", STATUS: false));
      }

      if (mResponse!.responseStatus == true) {
        Map data = mResponse.responseData as Map;
        List questions = data['questions'] as List;
        List<QuizQuestions> basics = [];
        for (var element in questions) {
          basics.add(QuizQuestions.fromMap(element));
        }
        Success mSuccess = Success(
            responseStatus: mResponse.responseStatus,
            responseData: {
              'questions': basics,
              'participated': (data['participated'] as List).isNotEmpty
            },
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

  Future<Either<Failure, Success>> setBasicResponse(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'contest/addQuizResponse',
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
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found!", STATUS: false));
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

  Future<Either<Failure, Success>> setGameResponse(
      HashMap<String, Object> requestParams) async {
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'contest/addGameResponse',
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
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found!", STATUS: false));
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
}
