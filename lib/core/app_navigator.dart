import 'package:flutter/material.dart';

void appNavPush(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void appNavReplace(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
