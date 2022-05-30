import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final text;
  final VoidCallback onPress;

  AdaptiveButton(this.text, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            child: Text(text),
            onPressed: onPress,
          )
        : TextButton(onPressed: onPress, child: Text(text));
  }
}
