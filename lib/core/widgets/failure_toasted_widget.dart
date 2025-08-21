import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastedWidget {
  ToastedWidget._();
  static void failureToastedWidget(String? msg) {
    final safeMsg =
        (msg == null || msg.trim().isEmpty) ? "Something went wrong 😕" : msg;
    Fluttertoast.showToast(
      msg: safeMsg,
      backgroundColor: const Color.fromARGB(255, 121, 12, 4),
    );
  }

  static void successToastedWidget(String? msg) {
    final safeMsg =
        (msg == null || msg.trim().isEmpty) ? "Login successful 🎉" : msg;
    Fluttertoast.showToast(
      msg: safeMsg,
      backgroundColor: const Color.fromARGB(255, 4, 116, 8),
    );
  }
}
