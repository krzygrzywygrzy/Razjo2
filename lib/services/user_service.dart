import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/exceptions.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/user.dart';

class UserService {
  Db db = Db(MONGO);

  Future<Either<Failure, User>> getUser(ObjectId id) async {
    try {
      await db.open();
      DbCollection collection = db.collection("users");
      Map<String, dynamic> result = await collection
          .findOne(where.id(id).excludeFields(['password', 'contacts']));
      if (result != null) {
        return Right(User.fromJson(result));
      } else
        throw DbException();
    } on SocketException {
      return Left(ConnectionFailure());
    } on DbException {
      return Left(DbFailure(message: "No user found"));
    }
  }

  Future<Either<Failure, bool>> editArray(
      ObjectId user, String field, String entry) async {
    try {
      await db.open();
      //TODO: finish
      throw UnimplementedError();
    } on DbException {
      return Left(DbFailure(message: "cannot edit array"));
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
