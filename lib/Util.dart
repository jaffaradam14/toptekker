import 'package:flutter/material.dart';

class Util {
  BuildContext context;

  Util(this.context);

  void showFlutterToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

}
