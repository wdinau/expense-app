import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final text;
  final VoidCallback onPress;

  AdaptiveFlatButton(this.text, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(text),
            onPressed: onPress,
          )
        : TextButton(onPressed: onPress, child: Text(text));
  }
}
