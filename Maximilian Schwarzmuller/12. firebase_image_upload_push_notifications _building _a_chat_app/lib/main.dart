import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/auth_screens.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // need permission only for ios and web
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

    // need permission only for ios and web
    // need permission only for ios and web

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepPurple,
        backgroundColor: Colors.pink,
        errorColor: Colors.red,
        accentColorBrightness: Brightness.dark,
        secondaryHeaderColor: Colors.white,
        fontFamily: 'Raleway',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.pinkAccent,
            onPrimary: Theme.of(context).secondaryHeaderColor,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Theme.of(context).primaryColor),
        ),
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
      // real time build stream for handling auth for firebase
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          }),
    );
  }
}
