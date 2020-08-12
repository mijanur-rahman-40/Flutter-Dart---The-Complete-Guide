import 'package:flutter/material.dart';

// import './question.dart';
// import './answer.dart';
import './quiz.dart';
import './result.dart';

void main() {
  // class instance is called by MyApp
  // runApp is a material package function
  runApp(MyApp());
}

// function return can also use with one expression
// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
class MyApp extends StatefulWidget {
  // here basically all widget is created
  // developer does not handle pixel value configuraion
  // every widget extend statefull or stateless widget

  // state --> State is data/Information used by app
  // app state --> Authenticated Users, Loaded jobs
  // Widget State --> Current User Input,Is a Loading Spinner being shown

  /*
     --> Stateless <--
     Input Data(data change externally) -> Widget -> Renders UI(Gets re-rendered when input data changed)
     --> Statefull <--
     Input Data(data change externally) -> Widget(internal state) -> Renders UI(Gets re-rendered when input data or local State changed)
  */
  // statefull widget basically contains two class
  // State Object also contains StatefulWidget
  // now create our own state
  // it returs MyAppState instance/or called
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

// State is import from material.dart
// State is a generic class
// the state however is persistent
// add pointer into State<>

// adding underscore before class name it means its a private class, it only accessable from that class
// can also use same process into function,variable name etc.
class MyAppState extends State<MyApp> {
  // trying to change some internal state of this widget
  // make static or (final questions = const['data'])
  static const _questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ]
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 1},
      ]
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 10},
        {'text': 'Mijan', 'score': 5},
        {'text': 'Blad', 'score': 3},
        {'text': 'Mead', 'score': 1},
      ]
    }
  ];

  // defaul uninitialized variable is null
  // var userName = 'max';
  // // this will work
  // userName = null;
  // // this will not work
  // userName = 1;

  var _questionIndex = 0;
  var _totalScore = 0;

  // reset quiz method
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  // handling state by button click
  void _answerQuestion(int score) {
    // print('Answer chosen!');
    // updating widget data(Or Using StatelessWidget Incorrectly)
    // questionInsex = questionInsex + 1;
    // print(questionInsex);

    // flutter state always does not change when we click anything
    // have to say state that want to change state
    // use setSate anynomous method which inherit State class

    // setSate function forces flutter to re-render the user interface
    // its called Build again and again
    _totalScore = _totalScore + score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    // if (questionInsex < questions.length) {
    //   print('We have more questions!');
    // } else {
    //   print('No more questions!');
    // }
  }

  @override
  Widget build(BuildContext context) {
    // context contains some metadata about this widget
    // every widget is also a dart class

    // var questions = [
    //   'What\'s your favorite color?',
    //   'What\'s your favorite animal?'
    // ];

    // here using map --> is a key value pair
    // const questions = const['data'] --> here variable and value both are constant, can not assign or add/change any new object/data
    // var questions = const['data'] --> here only value/data is constant, can assign but can not add/change new object/data
    // var questions = ['data'] --> here variable and value both are normal, can assign or add/change any new object/data

    // if a list of values will never change then make the whole variable a constant so that the lis is proctected against changes
    // basically  const questions = const [''] and  const questions = [''] are same
    /*
    const questions = [
      {
        'questionText': 'What\'s your favorite color?',
        'answers': ['Black', 'Red', 'Green', 'White']
      },
      {
        'questionText': 'What\'s your favorite animal?',
        'answers': ['Rabbit', 'Snake', 'Elephant', 'Lion']
      },
      {
        'questionText': 'Who\'s your favorite instructor?',
        'answers': ['Max', 'Mijan', 'Blad', 'Mead']
      }
    ];
    */

    // questions = [] --> does not work if questions is a constant

    /*
    // this will not work
    const dummy1 = const['hello'];
    dummy1.add('Mijan');
    print(dummy1);

    // this will work
    var dummy1 = ['hello'];
    dummy1.add('Mijan');
    print(dummy1);
    
    var dummy2 = const ['hello'];
    // this will not work
    dummy2.add('Mijan');
    print(dummy2);
    // this work successfully
    dummy2 = ['data'];
    */

    /**
     * Difference between final and const
     * final --> it is a runtime const value
     * const --> it is a compile time const value.Compile time constatnt also implicity means runtime constant.
     */

    return MaterialApp(
      // Scaffold is a another widget which is baked into material.dart
      // Scaffold has the job of creating a base page design for the app
      // Scaffold has also tons of arguments
      // it includes design structure, color scheme or coloring
      home: Scaffold(
          // this AppBar is a pre build material.dart package appbar
          // always add comma after closinf parentheses, cause this will allow to autofotmat
          appBar: AppBar(
            title: Text('My First App'),
          ),
          // body: Text('This is, my default Text!'),
          /**
         * Different types of widget
         * 1. Output $ Input(visivle) --> RaisedButton(),Text(),Card().....
         * Drawn onto the screen: 'What the user sees'
         * 2. Layout & Controls(invisible) Layout -->Row(), Column(), ListView()......
         * Give app structure and control how visible widgets are drawn into the screen (indirectly visible)
         */
          /**
         * Container() widget is into both category, but it is defult is invisible when add styles then it comes into
         */
          /**
         * Children takes a list of widget
         * A single widget contains only one child
         */
          // body: Column(children: <Widget>[],),
          // children: <Widget>[] --> this angled bracket widget, this is a so-called generic type, so a little annotation, type inference

          // here Column can be used into seperate filefor more readable
          // splitting the app into widget
          body: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                )
              /*
             Column(
                children: [
                  // Text('This question!'),
                  // Text(questions.elementAt(0)),
                  // Text(questions[0]),
                  // if use a stateless widget, index is changed but data can not re-rendered
                  // Text(questions[questionInsex]),
                  // use customwidget from another class
                  Question(questions[questionInsex]['questionText']),
                  //  onPressed: null --> means button is disabled
                  // RaisedButton(
                  //   child: Text('Answer 1'),
                  //   // onPressed: null,
                  //   // remove a parentheses from a function is passing a pointer
                  //   // when function is void function then called function without parameter
                  //   onPressed: answerQuestion,
                  // ),
                  // RaisedButton(
                  //   child: Text('Answer 2'),
                  //   // onPressed: answerQuestion,
                  //   // use anonymous function
                  //   onPressed: () => print('Answer 2 chosen'),
                  // ),
                  // RaisedButton(
                  //   child: Text('Answer 3'),
                  //   // onPressed: answerQuestion,
                  //   // use anonymous function
                  //   onPressed: () {
                  //     print('Answer 3 chosen');
                  //   },
                  // )
                  // _answerQuestion reference is a callback function
                  // Answer(_answerQuestion),
                  // Answer(_answerQuestion),
                  // Answer(_answerQuestion)

                  // return list of widget
                  // have to tell map that what type of object trying to iterate
                  // here use spread operator cause to avoid using nested list as children is list
                  // here spread operator helps to add this list with the children default list
                  // ...(questions[questionInsex]['answers'] as List<String>)
                  //     .map((answer) {
                  //   return Answer(_answerQuestion, answer);
                  // }).toList()

                  // inline return
                  ...(questions[questionInsex]['answers'] as List<String>)
                      .map((answer) => Answer(_answerQuestion, answer))
                      .toList()
                  //toList Creates a [List] containing the elements of this [Iterable]
                ],
              )
              */
              // Center() --> is a another widget that centers all the content horizontally and vertically on the page
              : Result(_totalScore, _resetQuiz)),
      // home: Text('Hello!'),
    );
  }
}
