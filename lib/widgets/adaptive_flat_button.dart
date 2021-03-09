import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function pressHandler;

  AdaptiveFlatButton({@required this.text, @required this.pressHandler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child:  Text(
              text,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
             onPressed: pressHandler)
        : FlatButton(
            onPressed: pressHandler,
            child: Text(
              text
            ),
            textColor: Theme.of(context).primaryColor,
          );
  }
}
