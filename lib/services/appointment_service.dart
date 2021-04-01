import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../core/const.dart';
import '../core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import '../models/appointment.dart';

class AppointmentService {
  ///Manages everything related to appointments
  /// [addAppointment] mangages to add the appointment to the appointment list
  /// [removeAppointment] manages to remove appointment

  Db db = Db(MONGO);

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

  Future<Either<Failure, bool>> removeAppointment() async {
    throw UnimplementedError();
  }
}
