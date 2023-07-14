import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:talentogram/controllers/contest_controller/contest_Manager_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/screens/contest_screens/contest_details.dart';
import 'package:talentogram/screens/contest_screens/count_down_screen.dart';
import 'package:talentogram/utils/app_colors.dart';

import '../../../utils/text_styles.dart';

class UpcomingOngoingContests extends StatelessWidget {
  const UpcomingOngoingContests({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContestManagerController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ht(40),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: wd(15)),
            child: Text(
              'IN-PROGRESS CONTESTS',
              style: subHeadingText(color: AppColors.textGrey),
            ),
          ),
          SizedBox(
            height: ht(150),
            child: controller.ongoingContest.isEmpty
                ? Center(child: Lottie.asset('assets/lottie/nodatagrey.json'))
                : ListView.builder(
                    padding: EdgeInsets.only(top: ht(14)),
                    itemCount: controller.ongoingContest.length,
                    itemBuilder: (context, index) {
                      return buildContainer(
                          index, controller.ongoingContest[index]);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
          ),
          SizedBox(
            height: ht(15),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: wd(15)),
            child: Text(
              'UPCOMING CONTESTS',
              style: subHeadingText(color: AppColors.textGrey),
            ),
          ),
          SizedBox(
            height: ht(150),
            child: controller.upcomingContest.isEmpty
                ? Center(child: Lottie.asset('assets/lottie/nodatagrey.json'))
                : ListView.builder(
                    padding: EdgeInsets.only(top: ht(14)),
                    itemCount: controller.upcomingContest.length,
                    itemBuilder: (context, index) {
                      return buildContainer(
                          index, controller.upcomingContest[index]);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
          ),
        ],
      );
    });
  }

  GestureDetector buildContainer(int index, ContestModel contest) {
    return GestureDetector(
      onTap: () {
        if (contest.isJoined) {
          Get.to(() => CountDownScreen(contest: contest));
        } else {
          Get.to(() => ContestDetails(contest: contest));
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: wd(15), left: index == 0 ? wd(15) : 0),
        padding: const EdgeInsets.all(15),
        height: wd(135),
        width: wd(240),
        decoration: ContainerProperties.simpleDecoration(radius: 16)
            .copyWith(color: AppColors.sparkliteblue4),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${contest.type.capitalizeFirst} Contest  ',
                      style:
                          subHeadingText(color: AppColors.sparkblue, size: 20),
                    ),
                  ),
                  Text(
                    contest.isJoined ? 'Participated ✔' : '',
                    style: subHeadingText(
                        color: AppColors.colorLogoGreenDark, size: 10),
                  ),
                ],
              ),
              Text(
                'Start:  ${contest.getFormatedDate(contest.converttoLocal(contest.startDate))}',
                style: normalText(color: AppColors.textGrey, size: 11),
              ),
              Text(
                'End:    ${contest.getFormatedDate(contest.converttoLocal(contest.endDate))}',
                style: normalText(color: AppColors.textGrey, size: 11),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration:
                        ContainerProperties.simpleDecoration(radius: 100)
                            .copyWith(color: AppColors.sparkliteblue5),
                    child: Text(
                      'Prize: ${contest.totalPrize}',
                      style: subHeadingText(color: AppColors.sparkblue),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'USERS ',
                        style: normalText(size: 14),
                      ),
                      CircularPercentIndicator(
                        radius: 27.0,
                        lineWidth: 4.0,
                        percent: 1,
                        center: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "${contest.participents}",
                                style: headingText(),
                              ),
                            )),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: AppColors.colorWhite,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
