import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import '../models/appointment.dart';

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
  Db db = Db(MONGO);

  //TODO: implement http request when api is implemented
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    return Right(_fakeAppointments);
  }

  Future<Either<Failure, bool>> addAppointment(
      Appointment appointment, String collection) async {
    try {
      await db.open();
      var res = await db.collection(collection).update(
            where.exists("collection"),
            modify.push(
              "appointments",
              appointment.toJson(),
            ),
          );
      if (res["err"] == null) {
        db.close();
        return Right(true);
      } else
        throw DbException();
    } on SocketException {
      db.close();
      return Left(ConnectionFailure());
    } on DbException {
      db.close();
      return Left(
        DbFailure(message: "Cannot send invitation!"),
      );
    }
  }
}
