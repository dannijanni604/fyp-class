import 'package:flutter/material.dart';

class Const {
  static labelText({
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static String? validateCode(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Code must contain 1 spacial, capital latter, numbers and eight characters in length';
      } else {
        return null;
      }
    }
  }

  static String? validateEmail(String value) {
    RegExp regex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$");
    if (value.isEmpty) {
      return "Please enter email";
    }
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  static List<Color> colors = [
    Colors.indigo,
    Colors.lightBlue,
    Colors.pinkAccent.shade400,
    Colors.lightGreen,
    Colors.amber.shade400,
    Colors.purple.shade400,
    Colors.blueAccent.shade400,
    Colors.black45,
    Colors.cyanAccent,
    Colors.orange.shade400,
    Colors.red.shade400,
    Colors.lightBlue,
    Colors.lime,
    Colors.lightBlueAccent,
  ];
}
