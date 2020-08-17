import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String buttonText;
  final Function clickHandler;

  AdaptiveFlatButton(this.buttonText, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child:
                Text(buttonText, style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: clickHandler,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: clickHandler,
            child:
                Text(buttonText, style: TextStyle(fontWeight: FontWeight.bold)),
          );
  }
}
