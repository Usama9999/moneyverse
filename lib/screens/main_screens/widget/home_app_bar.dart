import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/mainScreen_controllers/home_screen_controller.dart';
import 'package:talentogram/controllers/mainScreen_controllers/navbar_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/utils/app_colors.dart';

import '../../chat_screens/chat_screen.dart';

Widget homeAppBar(HomeScreenController controller) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: wd(15)),
    height: ht(45),
    width: double.infinity,
    child: Row(children: [
      InkWell(
          onTap: () {
            Get.find<NavBarController>().openDrawer();
          },
          child: const Icon(
            Icons.menu,
            size: 27,
            color: AppColors.sparkblue,
          )),
      Expanded(child: Image.asset('assets/images/line_logo.png')),
      InkWell(
          onTap: () {
            Get.to(() => const ChatScreen());
          },
          child: Image.asset(
            'assets/images/ic_chat.png',
            height: 28,
            color: AppColors.primaryColor,
          )),
    ]),
  );
}
