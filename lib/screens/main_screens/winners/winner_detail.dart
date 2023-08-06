import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talentogram/controllers/contest_controller/winners_controller.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/screens/main_screens/winners/widget/post_winner_response.dart';
import 'package:talentogram/utils/text_styles.dart';

class WinnerDetails extends StatefulWidget {
  final int userId;
  final int contestId;
  final String type;
  const WinnerDetails(
      {super.key,
      required this.contestId,
      required this.userId,
      required this.type});

  @override
  State<WinnerDetails> createState() => _WinnerDetailsState();
}

class _WinnerDetailsState extends State<WinnerDetails> {
  var controller = Get.put(WinnerController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.getWinnerDetails(widget.userId, widget.contestId, widget.type);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(''),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: wd(15)),
            children: [
              Text(
                "Winner Response",
                style: subHeadingText(size: 25),
              ),
              SizedBox(
                height: ht(20),
              ),
              GetBuilder<WinnerController>(builder: (value) {
                if (value.winnerDetailsLoader || value.winnerDetails.isEmpty) {
                  return Container();
                }
                if (widget.type == 'quiz') {
                  return Column(
                    children: [
                      Text(
                        '${value.winnerDetails['correct']} / ${value.winnerDetails['total']}',
                        style: subHeadingText(size: wd(50)),
                      ),
                    ],
                  );
                }
                if (widget.type == 'post') {
                  return Column(
                    children: [
                      UserPostResponse(
                        post: value.winnerDetails,
                      )
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You completed game at ${getFormatedDate(value.winnerDetails['createdAt'])}',
                      style: regularText(size: wd(15)),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: ht(100),
              )
            ],
          ),
          GetBuilder<WinnerController>(builder: (value) {
            return AppViews.loadingScreen(value.winnerDetailsLoader,
                opacity: 1);
          }),
          GetBuilder<WinnerController>(builder: (value) {
            return AppViews.showGif(value.error, 'nodata',
                text: 'Winner details unavailable');
          })
        ],
      ),
    );
  }

  String getFormatedDate(createdAt) {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(createdAt, true);
    var dateLocal = dateTime.toLocal();
    final DateFormat formatter = DateFormat("MMM dd, HH:mm:ss a");
    final String formatted = formatter.format(dateLocal);
    return formatted;
  }
}
