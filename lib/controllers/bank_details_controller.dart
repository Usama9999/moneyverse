import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talentogram/globals/enum.dart';
import 'package:talentogram/globals/global.dart';
import 'package:talentogram/respositories/user_repo.dart';

class BankDetailController extends GetxController {
  TextEditingController countryController =
      TextEditingController(text: 'India');
  TextEditingController bankName = TextEditingController(text: '');
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController address = TextEditingController(text: '');
  TextEditingController swift = TextEditingController(text: '');
  TextEditingController branchCode = TextEditingController(text: '');

  FocusNode numberNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode swiftNode = FocusNode();
  FocusNode countryNode = FocusNode();
  FocusNode bankNameNode = FocusNode();
  FocusNode branchCodeNode = FocusNode();

  String codeC = 'pk';

  bool loading = false;

  changeFlag(String name, String code) {
    countryController.text = name;
    codeC = code.toLowerCase();
    update();
  }

  bool validate() {
    if (!Global.checkNull(bankName.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter bank name',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(bankNameNode);
      return false;
    }
    if (!Global.checkNull(numberController.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter bank account number',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(numberNode);
      return false;
    }
    if (!Global.checkNull(nameController.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter account holder name',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(nameNode);
      return false;
    }
    if (!Global.checkNull(address.text.toString().trim())) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: 'Please enter full address',
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(Get.overlayContext!).requestFocus(addressNode);
      return false;
    }

    return true;
  }

  Future<void> addBank() async {
    if (!validate()) return;
    loading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    requestParams['country'] = countryController.text;
    requestParams['address'] = address.text.trim();
    requestParams['bankName'] = bankName.text.trim();
    requestParams['accountNo'] = numberController.text.trim();
    requestParams['swiftCode'] = swift.text.trim();
    requestParams['holderName'] = nameController.text.trim();
    requestParams['branchCode'] = branchCode.text.trim();

    var res = await UserRepo().addBankDetails(requestParams);

    res.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      loading = false;
      update();
    }, (mResult) async {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: "Bank details updated successfully",
          toastType: TOAST_TYPE.toastSuccess);
      loading = false;
      update();
    });
  }

  Future<void> getDetails() async {
    loading = true;
    update();
    HashMap<String, Object> requestParams = HashMap();

    var res = await UserRepo().getBankDetails(requestParams);

    res.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      loading = false;
      update();
    }, (mResult) async {
      if ((mResult.responseData as List).isNotEmpty) {
        Map data = (mResult.responseData as List)[0] as Map;
        bankName.text = data['bankName'];
        numberController.text = data['accountNo'];
        countryController.text = data['country'];
        swift.text = data['swiftCode'];
        address.text = data['address'];
        nameController.text = data['holderName'];
      }
      loading = false;
      update();
    });
  }
}
