import 'package:flutter/material.dart';

Future<void> showAlertDialog(context, String error) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Error!"),
        content: Text(error),
      );
    },
  );
}
