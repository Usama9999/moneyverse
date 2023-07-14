import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talentogram/controllers/contest_controller/quiz_contest_cont.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/globals/app_views.dart';
import 'package:talentogram/globals/widgets/appbars.dart';
import 'package:talentogram/globals/widgets/primary_button.dart';
import 'package:talentogram/models/contest_model.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

import 'radio_question.dart';

class QuizContest extends StatefulWidget {
  final ContestModel contest;
  const QuizContest({super.key, required this.contest});

  @override
  State<QuizContest> createState() => _QuizContestState();
}

class _QuizContestState extends State<QuizContest> {
  var controller = Get.put(QuizQuestionsController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.getQuestions(widget.contest);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.showCustomAlertExit(),
      child: Scaffold(
        appBar: customAppBar('', isCentered: true, onBack: () {
          controller.showCustomAlertExit();
        }),
        body: GetBuilder<QuizQuestionsController>(builder: (controller) {
          return Stack(
            children: [
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: wd(15)),
                children: [
                  Text(
                    'Please select the right option in least amount of time',
                    style: subHeadingText(color: AppColors.textGrey, size: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.basicQuestion.length,
                      itemBuilder: (context, index) {
                        return RadioQuestion(
                          question: controller.basicQuestion[index],
                        );
                      }),
                  SizedBox(
                    height: ht(18),
                  ),
                  CustomButton(
                      label: 'Submit',
                      onPress: () {
                        controller.addResponse(widget.contest.contestId);
                      }),
                  SizedBox(
                    height: ht(18),
                  ),
                ],
              ),
              AppViews.loadingScreen(controller.isLoading, opacity: 1),
              AppViews.showGif(controller.participated, 'api',
                  text: 'Your response was submitted successfully')
            ],
          );
        }),
      ),
    );
  }
}
