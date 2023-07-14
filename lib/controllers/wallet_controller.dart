import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  int currentTab = 0;

  bool isSaveCard = false;

  List<String> cashPrices = ['100', '200', '300', '500', '1k', '5k'];
  List<Tab> profileTabs = [
    const Tab(
      text: 'Coin',
    ),
    const Tab(
      text: 'Live revenue',
    ),
    const Tab(
      text: 'Cash',
    ),
  ];
  List<Tab> cardTabs = [
    const Tab(
      text: 'Deposit',
    ),
    const Tab(
      text: 'Withdraw',
    ),
  ];

  late TabController tabController;

  TextEditingController controllerCardNumber = TextEditingController();
  TextEditingController controllerCVC = TextEditingController();
  TextEditingController controllerHolder = TextEditingController();
  TextEditingController controllerExpiry = TextEditingController();

  FocusNode focusNodeCardNumber = FocusNode();
  FocusNode focusNodeCVC = FocusNode();
  FocusNode focusNodeHolder = FocusNode();
  FocusNode focusNodeExpiry = FocusNode();

  void changeTab(int index) {
    currentTab = index;
    update();
  }

  void changeSaveCard() {
    isSaveCard = isSaveCard ? false : true;
    update();
  }
}
