import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/appointment.dart';

List<Appointment> _fakeAppointments = [
  Appointment(
    name: "Michał",
    surname: "Bednarz",
    id: "12",
    date: DateTime(2021, 5, 12),
    time: TimeOfDay(hour: 12, minute: 0),
  ),
  Appointment(
    name: "Zenon",
    surname: "Drabiniarz",
    id: "13",
    date: DateTime(2021, 5, 12),
    time: TimeOfDay(hour: 12, minute: 5),
  ),
];

class AppointmentService {
  //TODO: implement http request when api is implemented
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    return Right(_fakeAppointments);
  }
}
