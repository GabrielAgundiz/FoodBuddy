import 'package:flutter/material.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class Utils {
  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    final messenger = messengerKey.currentState;
    if (messenger != null) {
      messenger.removeCurrentSnackBar();
      messenger.showSnackBar(snackBar);
    }
  }
}
