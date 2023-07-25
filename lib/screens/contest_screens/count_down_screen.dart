import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/contest_controller/contest_Manager_controller.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/screens/contest_screens/time_builder.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class CountDownScreen extends StatefulWidget {
  final ContestModel contest;

  const CountDownScreen({super.key, required this.contest});

  @override
  State<CountDownScreen> createState() => _CountDownScreenState();
}

class _CountDownScreenState extends State<CountDownScreen> {
  var controll = Get.put(ContestManagerController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controll.calculateTime(widget.contest);
    });
    super.initState();
  }

  @override
  void dispose() {
    controll.cancelTime();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('', isCentered: true),
      body: GetBuilder<ContestManagerController>(builder: (value) {
        return value.timerLoading
            ? AppViews.showLoading()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: wd(15)),
                children: [
                  Text(
                    'MoneyVerse Contest will start in:',
                    style: subHeadingText(size: 22, color: AppColors.textGrey),
                  ),
                  SizedBox(
                    height: ht(20),
                  ),
                  CountdownBuilder(
                      start: widget.contest.getStartTime,
                      now: value.datenow,
                      contest: widget.contest),
                  SizedBox(
                    height: ht(40),
                  ),
                  Row(
                    children: [
                      moodScrore(),
                      SizedBox(
                        width: wd(20),
                      ),
                      motivationalQoute(),
                    ],
                  ),
                  SizedBox(
                    height: ht(40),
                  ),
                  Container(
                    decoration: ContainerProperties.shadowDecoration(
                        color: AppColors.sparkliteblue4, blurRadius: 1),
                    padding: EdgeInsets.all(wd(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Following are the instruction for this contest:',
                          style: headingText(size: 18),
                        ),
                        SizedBox(
                          height: ht(10),
                        ),
                        Column(
                          children: List.generate(
                            getRules.length,
                            (index) => dotRow(getRules[index]),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Expanded timeContainer(String number, String text) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: AppColors.lightPurple,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.15),
                  offset: const Offset(0, 4),
                  blurRadius: 3,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: headingText(size: 24, color: Colors.black),
              ),
              Text(
                text,
                style: normalText(size: 11, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> postRules = [
    "If your post is in top most 3 liked posts of this contest, you will be a winner",
    "Please fill up your bank account information to get reward money",
    "After the end of the contest MoneyVerse team will contact the winners",
  ];
  List<String> quizRules = [
    "The subject of the quiz is the event name given in contest details",
    "After your participation you will be able to see a timer screen indiciating the time remaining of start of Quiz. You must be there before the start time of quiz or you will miss the chance to be on TOP",
    "The top 3 participents with highest marks and fastest completion time will be considered as the winners of this contest",
    "Winner must provide their bank information to get reward money",
    "After the end of the contest MoneyVerse team will contact the winners"
  ];
  List<String> gameRules = [
    "The subject of the Puzzle game is the event name given in contest details",
    "After your participation you will be able to see a timer screen indiciating the time remaining of start of Puzzle Game. You must be there before the start time of Game or you will miss the chance to be on TOP",
    "The first 3 participents who manage to solve the puzzle before anyone else will be the considered as winners of this contest",
    "Winner must provide their bank information to get reward money",
    "After the end of the contest MoneyVerse team will contact the winners"
  ];

  List<String> get getRules => widget.contest.type == 'post'
      ? postRules
      : widget.contest.type == 'game'
          ? gameRules
          : quizRules;
  Padding dotRow(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: ht(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style: normalText(),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text,
              style: normalText(),
            ),
          )
        ],
      ),
    );
  }

  Expanded motivationalQoute() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ht(170),
          child: Stack(children: [
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(top: 20),
              height: ht(160),
              decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.4),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 0),
                  ]),
            ),
            Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ht(20)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                offset: const Offset(0, 5),
                                blurRadius: 6,
                                spreadRadius: 5),
                          ]),
                      height: ht(110),
                      width: ht(110),
                      child: FittedBox(
                        child: Text(
                          widget.contest.totalPrize.toString(),
                          style: headingText(color: AppColors.green),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/ic_money.png',
                                height: 15,
                              ),
                              Text(
                                ' ${((widget.contest.totalPrize / 100) * 50).toDouble().floor()}',
                                textAlign: TextAlign.center,
                                style: normalText(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/ic_money.png',
                                height: 15,
                              ),
                              Text(
                                ' ${((widget.contest.totalPrize / 100) * 30).toDouble().floor()}',
                                textAlign: TextAlign.center,
                                style: normalText(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/ic_money.png',
                                height: 15,
                              ),
                              Text(
                                ' ${((widget.contest.totalPrize / 100) * 20).toDouble().floor()}',
                                textAlign: TextAlign.center,
                                style: normalText(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                )),
          ]),
        )
      ],
    ));
  }

  Expanded moodScrore() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ht(170),
          child: Stack(children: [
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(top: 20),
              height: ht(160),
              decoration: BoxDecoration(
                  color: AppColors.paleYellow,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 0),
                  ]),
            ),
            Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ht(20)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                offset: const Offset(0, 4),
                                blurRadius: 10,
                                spreadRadius: 2),
                          ]),
                      height: ht(110),
                      width: ht(110),
                      child: FittedBox(
                        child: Text(
                          widget.contest.participents.toString(),
                          style: headingText(color: AppColors.warning),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Users joined this contest',
                      textAlign: TextAlign.center,
                      style: normalText(),
                    ),
                    const Spacer(),
                  ],
                )),
          ]),
        )
      ],
    ));
  }
}
