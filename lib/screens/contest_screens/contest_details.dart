import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/contest_controller/contest_Manager_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/container_properties.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class ContestDetails extends StatefulWidget {
  final ContestModel contest;
  const ContestDetails({super.key, required this.contest});

  @override
  State<ContestDetails> createState() => _ContestDetailsState();
}

class _ContestDetailsState extends State<ContestDetails> {
  var controller = Get.put(ContestManagerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('', isCentered: true),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: wd(15)),
            children: [
              SizedBox(
                height: ht(10),
              ),
              Text(
                'Contest Details'.toUpperCase(),
                style: headingText(size: 16, color: AppColors.textGrey),
              ),
              SizedBox(
                height: ht(10),
              ),
              detailsBox(),
              SizedBox(
                height: ht(25),
              ),
              Text(
                'PRIZE DISTRIBUTION:',
                style: headingText(size: 16, color: AppColors.textGrey),
              ),
              SizedBox(
                height: ht(10),
              ),
              priceBox(),
              SizedBox(
                height: ht(15),
              ),
              Text(
                'INSTRUCTIONS',
                style: headingText(size: 16, color: AppColors.textGrey),
              ),
              SizedBox(
                height: ht(10),
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
              if (widget.contest.type == 'post')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ht(15),
                    ),
                    Text(
                      'WARNING',
                      style: headingText(size: 16, color: AppColors.error),
                    ),
                    SizedBox(
                      height: ht(10),
                    ),
                    Container(
                      decoration: ContainerProperties.shadowDecoration(
                          color: AppColors.error.withOpacity(0.4),
                          blurRadius: 1),
                      padding: EdgeInsets.all(wd(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          dotRow(
                              "If you try to like your post with different account on same device then those likes will not count for the contest")
                        ],
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomButton(
                    label: 'participate',
                    onPress: () {
                      controller.participate(widget.contest);
                    }),
              ),
            ],
          ),
          GetBuilder<ContestManagerController>(
              builder: (value) =>
                  AppViews.loadingScreen(value.participateLoading))
        ],
      ),
    );
  }

  List<String> postRules = [
    "You can participate in contest for only once. You won't be able to add more then one post",
    "The top 3 post with most likes will be considered as the winner of this contest",
    "Winner must provide their bank information to get reward money",
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

  Container priceBox() {
    return Container(
      decoration: ContainerProperties.shadowDecoration(
          color: AppColors.sparkliteblue4, blurRadius: 1),
      padding: EdgeInsets.all(wd(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price will be districuted by following creteria:',
            style: headingText(size: 18),
          ),
          SizedBox(
            height: ht(10),
          ),
          dotRow(
              '1st Position holder will get Rs. ${((widget.contest.totalPrize / 100) * 50).floor()}'),
          dotRow(
              '2nt Position holder will get Rs. ${((widget.contest.totalPrize / 100) * 30).floor()}'),
          dotRow(
              '3st Position holder will get Rs. ${((widget.contest.totalPrize / 100) * 20).floor()}'),
        ],
      ),
    );
  }

  Container detailsBox() {
    return Container(
      decoration: ContainerProperties.shadowDecoration(
          color: AppColors.sparkliteblue4, blurRadius: 1),
      padding: EdgeInsets.all(wd(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contest Type:',
            style: headingText(size: 18),
          ),
          SizedBox(
            height: ht(10),
          ),
          Text(
            '${widget.contest.type.capitalizeFirst!} Contest',
            style: normalText(),
          ),
          SizedBox(
            height: ht(15),
          ),
          Text(
            'Event Name:',
            style: headingText(size: 18),
          ),
          SizedBox(
            height: ht(10),
          ),
          Text(
            widget.contest.event.capitalizeFirst!,
            style: normalText(),
          ),
          SizedBox(
            height: ht(15),
          ),
          Text(
            'Entry Fee:',
            style: headingText(size: 18),
          ),
          SizedBox(
            height: ht(10),
          ),
          Row(
            children: [
              Image.asset(
                'assets/images/ic_coin.png',
                height: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "${widget.contest.entryFee}",
                style: normalText(),
              ),
            ],
          ),
          SizedBox(
            height: ht(15),
          ),
          Text(
            'Partcipents Till Now:',
            style: headingText(size: 18),
          ),
          SizedBox(
            height: ht(10),
          ),
          Text(
            "${widget.contest.participents}",
            style: normalText(),
          ),
          SizedBox(
            height: ht(15),
          ),
          Text(
            'Start Time:',
            style: headingText(size: 18),
          ),
          SizedBox(
            height: ht(10),
          ),
          Text(
            widget.contest.getFormatedDate(
                widget.contest.converttoLocal(widget.contest.startDate)),
            style: normalText(),
          ),
          SizedBox(
            height: ht(15),
          ),
          Text(
            'End Time:',
            style: headingText(size: 18),
          ),
          SizedBox(
            height: ht(10),
          ),
          Text(
            widget.contest.getFormatedDate(
                widget.contest.converttoLocal(widget.contest.endDate)),
            style: normalText(),
          ),
        ],
      ),
    );
  }
}
