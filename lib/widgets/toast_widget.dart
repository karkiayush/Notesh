import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../theme/colors.dart';

class ToastWidget {
  static getErrorToast(e) {
    return Fluttertoast.showToast(
      msg: "Error: ${e.toString()}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      fontSize: 16,
    );
  }

  static getMessageToast(msg) {
    return Fluttertoast.showToast(
      msg: msg,
      textColor: textColor,
      fontSize: 25,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.deepPurpleAccent,
      timeInSecForIosWeb: 2,
    );
  }
}
