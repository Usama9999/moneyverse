// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talentogram/globals/constants.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/url_collection.dart';

class ReqListener {
  static Future<String> fetchPost(
      {required String strUrl,
      required HashMap<String, Object> requestParams,
      required ReqType mReqType,
      required ParamType mParamType}) async {
    HashMap<String, String> lHeaders = HashMap();

    final prefs = await SharedPreferences.getInstance();
    String? accesToken = prefs.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    if (accesToken != null && accesToken.isNotEmpty) {
      String accesTokenType = Constants.strTokenType;
      accesToken = "$accesTokenType $accesToken";
      lHeaders[PARAMS.PARAM_AUTHORIZATION] = accesToken;
    }

    if (mParamType == ParamType.json) {
      lHeaders["Content-Type"] = "application/json";
      lHeaders["Accept"] = "application/json";
    }
    late http.Response? response;

    switch (mReqType) {
      case ReqType.get:
        var param = '';
        if (requestParams.isNotEmpty) {
          param = '?';
          requestParams.forEach((key, value) {
            param += '$key=$value&';
          });
        }
        response = await http
            .get(Uri.parse(RequestBuilder.useUrl + strUrl + param),
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.post:
        response = await http
            .post(Uri.parse(RequestBuilder.useUrl + strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.patch:
        response = await http
            .patch(Uri.parse(RequestBuilder.useUrl + strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.put:
        response = await http
            .put(Uri.parse(RequestBuilder.useUrl + strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.delete:
        response = await http
            .delete(Uri.parse(RequestBuilder.useUrl + strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
    }

    debugPrint("REQ. lHeaders : $lHeaders");
    debugPrint("REQ. PARAMS : $requestParams");
    debugPrint("REQ. URL : ${RequestBuilder.useUrl}$strUrl");
    debugPrint("REQ. BODY : ${response.body.toString()}");

    return response.body;
  }
}
