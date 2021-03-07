import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
        title: 'Flutter Chat',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,
          errorColor: Colors.red,
          secondaryHeaderColor: Colors.white,
          fontFamily: 'Raleway',
          iconTheme: ThemeData.light()
              .iconTheme
              .copyWith(color: Colors.purple, size: 25),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
                headline2: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple),
                headline3: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                bodyText1: TextStyle(fontSize: 20),
              ),
        ),
        home: ChatScreen(),
    );
  }
}
