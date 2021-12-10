import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function onPressedHandler;
  AdaptiveFlatButton(this.text, this.onPressedHandler);


  @override
  Widget build(BuildContext context) {
    return Platform.isIOS? CupertinoButton(
      child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, )
      ),
      onPressed: onPressedHandler,
    ): FlatButton(
        onPressed: onPressedHandler,
        textColor: Colors.blue,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, ),
        )
    );
  }


}
