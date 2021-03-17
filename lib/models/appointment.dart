import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Appointment extends Equatable {
  Appointment({this.name, this.surname, this.id, this.date, this.time});

  final String id;
  final String name;
  final String surname;
  final DateTime date;
  final TimeOfDay time;

  factory Appointment.formJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'].toString(),
      name: json['name'],
      surname: json['surname'],
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
      'surname': surname,
      'year': date.year.toString(),
      'month': date.month.toString(),
      'day': date.day.toString(),
      'hour': time.hour.toString(),
      'minute': time.minute.toString(),
    };
  }

  @override
  List<Object> get props => [id, name, surname, date, time];
}
