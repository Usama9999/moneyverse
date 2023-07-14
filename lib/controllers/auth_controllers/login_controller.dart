import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/respositories/auth_repo.dart';
import 'package:talentogram/screens/main_screens/bottom_bar_screen.dart';
import 'package:talentogram/utils/app_colors.dart';

import '../../globals/container_properties.dart';

class LoginController extends GetxController {
  bool isRememberMe = false;
  bool isLoading = false;

  List<Accounts> accounts = [];
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FocusNode focusNodeEmail = FocusNode();

  FocusNode focusNodePassword = FocusNode();

  TextEditingController controllerPhone = TextEditingController();

  FocusNode focusNodePhone = FocusNode();

  rememberMe(bool value) {
    isRememberMe = value;
    update();
  }

  bool validateion() {
    if (!Global.checkNull(controllerEmail.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter email',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(focusNodeEmail);
      return false;
    }
    if (!Global.checkNull(controllerPassword.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "ok",
          strMsg: 'Please enter password',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(focusNodePassword);
      return false;
    }

    return true;
  }

  loginWithGoogle() async {
    var googleSign = GoogleSignIn(scopes: ["email"]);
    final user = await googleSign.signIn();
    final googleAuth = await user!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      if (value.additionalUserInfo!.isNewUser) {
        signupTask(
          "google",
          value.additionalUserInfo!.profile!['name'],
          value.additionalUserInfo!.profile!['name'],
          value.additionalUserInfo!.profile!['email'],
        );
      } else {
        loginTask();
      }
    });
  }

  loginTask() async {
    if (!validateion()) {
      return;
    }
    isLoading = true;

    update();
    HashMap<String, Object> requestParams = HashMap();

    requestParams['email'] = controllerEmail.text;
    requestParams['password'] = controllerPassword.text;

    var signInEmail = await AuthRepo().login(requestParams);

    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      isLoading = false;
      update();
    }, (mResult) {
      isLoading = false;
      update();
      Get.offAll(() => const NavBarScreen());
      if (isRememberMe) {
        storeAccounts();
      }
    });
  }

  signupTask(
      String source, String firstName, String lastName, String email) async {
    HashMap<String, Object> requestParams = HashMap();
    requestParams['firstName'] = firstName;
    requestParams['lastName'] = lastName;
    requestParams['email'] = email;
    requestParams['phone'] = "";
    requestParams['userName'] = "user${FirebaseAuth.instance.currentUser!.uid}";
    requestParams['authId'] = FirebaseAuth.instance.currentUser!.uid;
    requestParams['source'] = source;
    requestParams['password'] = '12345';

    var signInEmail = await AuthRepo().signup(requestParams);
    // isShowLoader = false;
    // update();
    signInEmail.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      isLoading = false;
      update();
    }, (mResult) {
      loginTask();
    });
  }

  Future<void> getSaved() async {
    accounts.clear();
    final prefs = await SharedPreferences.getInstance();
    List<String> accountsSaved = prefs.getStringList("accounts") ?? [];
    for (var account in accountsSaved) {
      log(account);
      accounts.add(Accounts.fromMap(jsonDecode(account)));
    }
    if (accounts.isNotEmpty && controllerEmail.text.isEmpty) {
      bottomSheet();
    }
  }

  bottomSheet() {
    return Get.bottomSheet(Container(
      padding: const EdgeInsets.all(15),
      height: 300,
      decoration: BoxDecoration(
          color: AppColors.colorWhite,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13), topRight: Radius.circular(13))),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 30,
            decoration:
                ContainerProperties.simpleDecoration(radius: 100.0).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Get.back();
                          controllerEmail.text = accounts[index].email;
                          controllerPassword.text = accounts[index].password;
                        },
                        child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            height: 40,
                            width: double.infinity,
                            child: Text(accounts[index].email)),
                      ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: accounts.length))
        ],
      ),
    ));
  }

  Future<void> storeAccounts() async {
    String account = jsonEncode(
        {'email': controllerEmail.text, 'password': controllerPassword.text});
    final prefs = await SharedPreferences.getInstance();
    List<String> accounts = prefs.getStringList("accounts") ?? [];

    for (int i = 0; i < accounts.length; i++) {
      if (jsonDecode(accounts[i])['email'] == controllerEmail.text &&
          jsonDecode(accounts[i])['password'] != controllerPassword.text) {
        accounts.removeAt(i);
      }
    }
    if (!accounts.contains(account)) {
      accounts.insert(0, account);
    } else {}
    if (accounts.length > 10) {
      accounts.removeLast();
    }
    prefs.setStringList("accounts", accounts);
  }
}

class Accounts {
  String email;
  String password;

  Accounts({required this.email, required this.password});
  factory Accounts.fromMap(Map<String, dynamic> json) =>
      Accounts(email: json['email'], password: json['password']);
}
