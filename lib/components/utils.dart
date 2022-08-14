import 'package:flutter/material.dart';
import 'package:petagon_admin/main.dart';

class Utils {
  static showSnackBar(String? text) {
    if (text == null) return;

    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  static errorSnackBar(IconData? icon, String? text) {
    if (text == null) return;

    final snackbar = SnackBar(
      content: Row(children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          text,
          maxLines: 2,
          softWrap: true,
        ))
      ]),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
