import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:razjo/models/appointment.dart';

void main() {
  final tAppointment = Appointment(
    name: "Oli",
    psyName: "Sykes",
    id: "1",
    date: DateTime(2020, 5, 12),
    time: TimeOfDay(hour: 12, minute: 0),
  );

  test("Should return valid Appointment model when Json is provided", () {
    //arrange
    var json =
        '{"name": "Oli", "psyName": "Sykes", "id": "1", "year": "2020", "month": "5", "day": "12", "hour": "12", "minute": "0"}';
    final Map<String, dynamic> jsonMap = jsonDecode(json);
    //act
    final result = Appointment.formJson(jsonMap);
    //assert
    expect(result, tAppointment);
  });

  test("Should return JSON map from Appointment model containing proper data",
      () {
    //act
    final result = tAppointment.toJson();
    //assert
    final expectedMap = {
      "id": "1",
      "name": "Oli",
      "psyName": "Sykes",
      "year": "2020",
      "month": "5",
      "day": "12",
      "hour": "12",
      "minute": "0"
    };
    expect(result, expectedMap);
  });
}
