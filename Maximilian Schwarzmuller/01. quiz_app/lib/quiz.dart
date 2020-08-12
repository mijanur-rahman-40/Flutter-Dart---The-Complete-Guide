import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.answerQuestion,
    @required this.questionIndex,
    @required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Question(questions[questionIndex]['questionText']),
      ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
          // .map((answer) => Answer(answerQuestion, answer['text']))
          
          // use anonymous function to passing data, when button is pressed then execute the anonymous function that trigger the answerQuestion function
          // basically passing function reference
          .map((answer) =>
              Answer(() => answerQuestion(answer['score']), answer['text']))
          .toList()
    ]);
  }
}
