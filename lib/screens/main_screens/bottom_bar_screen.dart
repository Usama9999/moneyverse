import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/mainScreen_controllers/navbar_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/extensions/color_extensions.dart';
import 'package:talentogram/screens/drawer/drawer.dart';
import 'package:talentogram/screens/main_screens/home_page/home_screen.dart';
import 'package:talentogram/screens/post_screens/add_post_screen.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

import 'profile/user_profile.dart';
import 'stats/stats_screen.dart';
import 'winners/winners_screen.dart';

class NavBarScreen extends StatefulWidget {
  final int index;
  const NavBarScreen({super.key, this.index = 0});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  var controller = Get.put(NavBarController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.changeTab(widget.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<NavBarController>(
        init: NavBarController(),
        builder: (value) {
          return WillPopScope(
            onWillPop: () => controller.onWillPop(),
            child: Scaffold(
              key: controller.key,
              drawer: const CustomDrawer(),
              body: SafeArea(
                child: Center(
                  child: IndexedStack(
                    index: value.currentIndex,
                    children: [
                      Visibility(
                        maintainState: true,
                        visible: value.currentIndex == 0,
                        child: const HomeScreen(),
                      ),
                      Visibility(
                        visible: value.currentIndex == 1,
                        child: const WinnersScreen(),
                      ),
                      Visibility(
                        maintainState: true,
                        visible: value.currentIndex == 2,
                        child: const AddPostScreen(),
                      ),
                      Visibility(
                        visible: value.currentIndex == 3,
                        child: const MyStats(),
                      ),
                      Visibility(
                        // maintainState: true,
                        visible: value.currentIndex == 4,
                        child: const ProfileScreen(),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: _bottomBar(value),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          );
        });
  }

  SizedBox _bottomBar(NavBarController value) {
    return SizedBox(
      height: ht(75),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(wd(18), ht(0), wd(18), ht(7)),
              decoration: BoxDecoration(
                  color: HexColor('#261E41'),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(17))),
              height: ht(60),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      value.changeTab(0);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: _dec(0),
                      margin: _mar(),
                      padding: padd(),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/ic_home.png',
                              height: 21,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "HOME",
                              style: style(0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      value.changeTab(1);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: _dec(1),
                      margin: _mar(),
                      padding: padd(),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/ic_winner.png',
                              height: 21,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "WINNERS",
                              style: style(1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  Expanded(child: Container()),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      value.changeTab(3);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: _dec(3),
                      margin: _mar(),
                      padding: padd(),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/ic_stats.png',
                              height: 27,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              "MY STATS",
                              style: style(3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      value.changeTab(4);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: _dec(4),
                      margin: _mar(),
                      padding: padd(),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/ic_profile.png',
                              height: 21,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text("PROFILE", style: style(4)),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container()),
              Expanded(child: Container()),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AddPostScreen());
                    },
                    child: Container(
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      height: ht(50),
                      width: wd(50),
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Icon(
                          Icons.add,
                          size: 30,
                          color: AppColors.primaryColor,
                        )),
                      ),
                    ),
                  ),
                ],
              )),
              Expanded(child: Container()),
              Expanded(child: Container()),
            ],
          )
        ],
      ),
    );
  }

  TextStyle style(int i) {
    return controller.currentIndex == i
        ? regularText(size: 10, color: Colors.white)
        : normalText(size: 10, color: Colors.white);
  }

  EdgeInsets padd() => const EdgeInsets.symmetric(horizontal: 3);

  EdgeInsets _mar() => EdgeInsets.only(top: ht(9));

  BoxDecoration _dec(int index) {
    return BoxDecoration(
        color: controller.currentIndex == index
            ? Colors.white.withOpacity(0.2)
            : null,
        borderRadius: BorderRadius.circular(8));
  }
}
