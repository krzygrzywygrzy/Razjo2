import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Appointment extends Equatable {
  Appointment({this.name, this.surname, this.id, this.date, this.time});

  final String id;
  final String name;
  final String surname;
  final DateTime date;
  final TimeOfDay time;

  factory Appointment.formJson(Map<String, dynamic> json){
    return Appointment(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson (){
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'date': date,
      'time': time,
    };
  }

  @override
  List<Object> get props => [id, name, surname, date, time];
}