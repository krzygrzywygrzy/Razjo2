import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/appointment.dart';

List<Appointment> fakeAppointments = [
  Appointment(
    name: "Jan",
    surname: "Bednarz",
    id: "12",
    date: DateTime(2021, 5, 12),
    time: TimeOfDay(hour: 12, minute: 0),
  ),
  Appointment(
    name: "Zeneon",
    surname: "Drabiniarz",
    id: "13",
    date: DateTime(2021, 5, 12),
    time: TimeOfDay(hour: 12, minute: 0),
  ),
];

class AppointmentService {
  //TODO: implement http request when api is implemented
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    return Right(fakeAppointments);
  }
}
