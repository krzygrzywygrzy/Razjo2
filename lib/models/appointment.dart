import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Appointment extends Equatable {
  Appointment({this.name, this.psyName, this.id, this.date, this.time});

  final String id;
  final String name;
  final String psyName;
  final DateTime date;
  final TimeOfDay time;

  factory Appointment.formJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'].toString(),
      name: json['name'],
      psyName: json['psyName'],
      date: DateTime(
        int.parse(json["year"]),
        int.parse(json["month"]),
        int.parse(json["day"]),
      ),
      time: TimeOfDay(
        hour: int.parse(json["hour"]),
        minute: int.parse(json["minute"]),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'psyName': psyName,
      'year': date.year.toString(),
      'month': date.month.toString(),
      'day': date.day.toString(),
      'hour': time.hour.toString(),
      'minute': time.minute.toString(),
    };
  }

  @override
  List<Object> get props => [id, name, psyName, date, time];
}
