import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Note extends Equatable {
  Note({this.patientEntry, this.psychologistEntry, this.id, this.date, this.time, this.name,});

  final String id;
  final String patientEntry;
  final String psychologistEntry;
  final String name;
  final DateTime date;
  final TimeOfDay time;

  factory Note.formJson (Map<String, dynamic> json){
    return Note(
      id: json["id"],
      patientEntry: json["patientEntry"],
      psychologistEntry: json["psychologistEntry"],
      name: json["name"],
      date: json["date"],
      time: json["time"],
    );
  }

  Map<String, dynamic> toJson (){
    return {
      "id": id,
      "patientEntry": patientEntry,
      "psychologistEntry": psychologistEntry,
      "name": name,
      "date": date,
      "time": time,
    };
  }

  @override
  List<Object> get props => [id, patientEntry, psychologistEntry, name, date, time];
}