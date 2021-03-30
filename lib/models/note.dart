import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Note extends Equatable {
  Note({
    this.entry,
    this.id,
    this.date,
    this.time,
    this.name,
  });

  final ObjectId id;
  final String entry;
  final String name;
  final DateTime date;
  final TimeOfDay time;

  factory Note.formJson(Map<String, dynamic> json) {
    return Note(
      id: json["id"],
      entry: json["entry"],
      name: json["name"],
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
      "entry": entry,
      "name": name,
      "year": date.year.toString(),
      "month": date.month.toString(),
      "day": date.day.toString(),
      "hour": time.hour.toString(),
      "minute": time.minute.toString(),
    };
  }

  @override
  List<Object> get props => [id, entry, name, date, time];
}
