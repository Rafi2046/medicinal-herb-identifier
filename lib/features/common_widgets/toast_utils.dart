import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void error(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: const Color(0xFFDC2626),
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 3,
    );
  }

  static void success(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: const Color(0xFF16A34A),
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
    );
  }

  static void info(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: const Color(0xFF1E293B),
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 2,
    );
  }
}
