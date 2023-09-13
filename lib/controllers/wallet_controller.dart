import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:talentogram/globals/widgets/dialogues/manager.dart';
import 'package:talentogram/respositories/user_repo.dart';

import '../globals/constants.dart';

class WalletController extends GetxController {
  bool loading = false;

  List<Map> offers = [
    {'tokens': 50, 'amount': 300},
    {'tokens': 100, 'amount': 500},
    {'tokens': 200, 'amount': 750},
    {'tokens': 300, 'amount': 1100},
    {'tokens': 500, 'amount': 2100},
  ];
  var paymentIntent;
  Future<void> makePayment(Map offer) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(offer['amount'], 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Ikay'))
          .then((value) {
        displayPaymentSheet(offer);
      }).catchError((err) {
        DialogueManager.showInfoDialogue(
            ('Something went wrong!. try again $err'));
      });
    } catch (err) {
      DialogueManager.showInfoDialogue(
          ('Something went wrong!. try again $err'));
    }
  }

  createPaymentIntent(int amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': (amount * 100).toString(),
        'currency': 'PKR',
      };
      loading = true;
      update();
      //Make post request to Stripe
      var response = await post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${Constants.stripeKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      loading = false;
      update();
      log(response.body);
      if (response.body.contains('error') &&
          !response.body.contains('client_secret')) {
        DialogueManager.showInfoDialogue(
            jsonDecode(response.body)['error']['message']);
      }
      return jsonDecode(response.body);
    } catch (err) {
      loading = false;
      update();
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(Map offer) async {
    await Stripe.instance.presentPaymentSheet().then((e) {
      DialogueManager.showInfoDialogue(
          "You have successfully purchased ${offer['tokens']}. Tokens. We wish you good luck for your future contests.");
      userData['balance'] += offer['tokens'];
      update();
      HashMap<String, Object> h = HashMap();
      h['tokens'] = offer['tokens'];
      UserRepo().buyTokens(h);
    }).catchError((e) {
      if (!e.toString().contains('FailureCode.Canceled')) {
        DialogueManager.showInfoDialogue(
            "You have successfully purchased ${offer['tokens']}. Tokens. We wish you good luck for your future contests.");
        userData['balance'] += offer['tokens'];
        update();
        HashMap<String, Object> h = HashMap();
        h['tokens'] = offer['tokens'];
        UserRepo().buyTokens(h);
      }
    });
  }

  Map userData = {"earnings": 0, "balance": 0};
  getTokens() async {
    HashMap<String, Object> requestParams = HashMap();
    loading = true;
    update();
    var res = await UserRepo().getMyData(requestParams);
    res.fold((failure) {
      Get.back();
      DialogueManager.showInfoDialogue(('Something went wrong!. try again'));
    }, (mResult) {
      userData = mResult.responseData as Map;
    });
    loading = false;
    update();
  }
}
