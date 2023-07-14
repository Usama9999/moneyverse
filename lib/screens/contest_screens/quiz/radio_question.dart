import 'package:flutter/material.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/models/quiz_questions.dart';
import 'package:talentogram/utils/app_colors.dart';
import 'package:talentogram/utils/text_styles.dart';

class RadioQuestion extends StatefulWidget {
  final QuizQuestions question;
  const RadioQuestion({super.key, required this.question});

  @override
  State<RadioQuestion> createState() => _RadioQuestionState();
}

class _RadioQuestionState extends State<RadioQuestion> {
  @override
  void initState() {
    // if (widget.question.answer.text.isEmpty && widget.question.fillRadio)
    //   widget.question.answer.text = widget.question.getOptionsArray.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ht(18),
        ),
        Text(
          widget.question.title,
          style: subHeadingText(size: 17, color: AppColors.primaryColor),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: List.generate(
              widget.question.getOptionsArray.length,
              (index) => GestureDetector(
                    onTap: () {
                      widget.question.answerCont.text =
                          widget.question.getOptionsArray[index];
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: ht(15)),
                      child: Row(
                        children: [
                          SizedBox(
                              height: 20,
                              width: 20,
                              child: Radio(
                                activeColor: AppColors.sparkliteblue2,
                                groupValue:
                                    widget.question.getOptionsArray[index],
                                onChanged: (value) {},
                                value: widget.question.answerCont.text,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            widget.question.getOptionsArray[index],
                            style: normalText(),
                          ))
                        ],
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
