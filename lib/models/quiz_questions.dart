// To parse this JSON data, do
//
//     final basicQuestions = basicQuestionsFromMap(jsonString);

import 'package:flutter/material.dart';

class QuizQuestions {
  QuizQuestions({
    required this.questionId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.answersOptions,
    required this.answer,
    required this.answerCont,
    required this.answerNode,
  });

  int questionId;
  String title;
  String createdAt;
  String updatedAt;
  String answersOptions;
  String answer;
  TextEditingController answerCont;
  FocusNode answerNode;

  factory QuizQuestions.fromMap(Map<String, dynamic> json) => QuizQuestions(
        questionId: json["questionId"],
        title: json["title"],
        answer: json["answer"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        answersOptions: json["answersOptions"],
        answerNode: FocusNode(),
        answerCont: TextEditingController(text: ''),
      );

  List<String> get getOptionsArray => answersOptions.split('*').toList();

  int get selected => getOptionsArray.indexOf(answerCont.text);

  setDropDownAnswer(int i) {
    answerCont.text = getOptionsArray[i];
  }
}
