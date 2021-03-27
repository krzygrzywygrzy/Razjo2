import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//TODO: refractor date and time

class Note extends Equatable {
  Note({
    this.entry,
    this.id,
    this.date,
    this.time,
    this.name,
  });

  final String id;
  final String entry;
  final String name;
  final DateTime date;
  final TimeOfDay time;

  factory Note.formJson(Map<String, dynamic> json) {
    return Note(
      id: json["id"],
      entry: json["entry"],
      name: json["name"],
      date: json["date"],
      time: json["time"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "entry": entry,
      "name": name,
      "date": date,
      "time": time,
    };
  }

  @override
  List<Object> get props => [id, entry, name, date, time];
}
