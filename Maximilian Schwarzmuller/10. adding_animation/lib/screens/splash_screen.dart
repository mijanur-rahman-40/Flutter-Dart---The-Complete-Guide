import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'Loading...',
        style: TextStyle(
          color: Theme.of(context).secondaryHeaderColor,
          fontSize: 40,
          fontFamily: 'Anton',
          fontWeight: FontWeight.normal,
        ),
      ),
    ));
  }
}
