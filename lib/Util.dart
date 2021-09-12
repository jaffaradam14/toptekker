import 'package:flutter/material.dart';

class Util {
  BuildContext context;

  Util(this.context);

  void showSnackBar(String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blue,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: Duration(
          seconds: 1,
          milliseconds: 100),
    ));
  }
}
