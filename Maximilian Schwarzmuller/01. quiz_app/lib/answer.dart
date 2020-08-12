import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  // function property
  // stored here has to be function pointer
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        // Colors.blue is a static property can use without instantiating class
        // this is the normal property, color is a basically a single value or hex code
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(
          answerText,
          style: TextStyle(fontSize: 18),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}
