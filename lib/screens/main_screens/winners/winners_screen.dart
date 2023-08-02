import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/contest_controller/winners_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/utils/text_styles.dart';

import 'widget/winner_card.dart';

class WinnersScreen extends StatefulWidget {
  const WinnersScreen({super.key});

  @override
  State<WinnersScreen> createState() => _WinnersScreenState();
}

class _WinnersScreenState extends State<WinnersScreen> {
  var controller = Get.put(WinnerController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.getPreviousContests();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('', isMain: true),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: wd(15)),
            children: [
              Text(
                "See the winners of previous contest",
                style: subHeadingText(size: 25),
              ),
              SizedBox(
                height: ht(20),
              ),
              GetBuilder<WinnerController>(builder: (value) {
                return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.contests.length,
                    itemBuilder: (context, index) {
                      ContestModel contest = value.contests[index];
                      return WinnerWidget(contest: contest);
                    });
              }),
              SizedBox(
                height: ht(100),
              )
            ],
          ),
          GetBuilder<WinnerController>(builder: (value) {
            return AppViews.loadingScreen(value.contestLoader);
          })
        ],
      ),
    );
  }
}
