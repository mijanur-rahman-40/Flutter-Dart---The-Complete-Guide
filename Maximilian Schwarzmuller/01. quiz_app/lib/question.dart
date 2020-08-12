import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  // this is a immutable class, if not use final
  // so use final, using final say that can not never change the value after its initialization here in the construtor
  final String questionText;

  // positional argument
  Question(this.questionText);
  // here Question is a default constructor
  // but can also create a multiples constructor
  // like: Question.addText(this.questionTex),Question.addAnotherText(this.questionTex)
  // this constructor called like : var q =  Question.addText('Hello')

  @override
  Widget build(BuildContext context) {
    // Container allows to space, align things
    // The core of the container always is the child {child(=Content)}
    // Container --> like : (Margin(Border(Padding(child(=Content)))))
    return Container(
      // width ensures that the container takes as much size, as much width as it can get
      width: double.infinity,
      // This here is a special constructor, EdgeInsets has multiple constructors.
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }
}
