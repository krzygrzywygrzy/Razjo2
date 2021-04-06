import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/exceptions.dart';
import 'package:razjo/core/erros/failures.dart';

class SettingService {
  Db db = Db(MONGO);

  Future<Either<Failure, bool>> savePrimary(
      String name, String surname, String email, ObjectId id) async {
    try {
      await db.open();
      var res = await db.collection("users").update(
          where.id(id), {"name": name, "surname": surname, "email": email});
      db.close();
      if (res["err"] != null) {
        return Right(true);
      } else
        throw DbException();
    } on DbException {
      return Left(DbFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
