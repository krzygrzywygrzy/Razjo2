import 'package:flutter/material.dart';

//TODO: change theme of pikcers

Future<DateTime> pickDate(context) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(
      Duration(
        days: 14,
      ),
    ),
  );
}

Future<TimeOfDay> pickTime(context) async {
  return await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
}
