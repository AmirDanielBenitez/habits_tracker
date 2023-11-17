import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habits_tracker/core/constants/constants.dart';

showToast(String text, {bool error = false}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: error ? Colors.red : kAccentColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
