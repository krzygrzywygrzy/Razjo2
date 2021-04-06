import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../core/const.dart';
import '../core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import '../models/user.dart';

class UserService {
  /// Manages everything related to users
  /// [getUser] manages to get user form MongoDB by [ObjectId]
  /// [editArray] manages to edit fields that are arrays in database
  /// [getUsers] manages to get list of users using [getUser] frunction

  Db db = Db(MONGO);

  Future<Either<Failure, User>> getUser(ObjectId id) async {
    try {
      await db.open();
      DbCollection collection = db.collection("users");
      Map<String, dynamic> result = await collection
          .findOne(where.id(id).excludeFields(['password', 'contacts']));
      db.close();
      if (result != null) {
        return Right(User.fromJson(result));
      } else
        throw DbException();
    } on SocketException {
      return Left(ConnectionFailure());
    } on DbException {
      return Left(DbFailure());
    }
  }

  Future<Either<Failure, bool>> editArray(
      ObjectId user, String field, String entry) async {
    try {
      await db.open();
      var response = await db.collection("users").update(
            where.id(user),
            modify.push(field, entry),
          );
      db.close();
      if (response["err"] == null) {
        return Right(true);
      } else
        throw DbException();
    } on DbException {
      return Left(DbFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<User>>> getUsers(List<ObjectId> ids) async {
    List<User> list = [];
    try {
      for (ObjectId id in ids) {
        var res = await this.getUser(id);
        if (res.isRight())
          list.add((res as Right).value);
        else {
          if ((res as Left).value is DbFailure)
            throw DbException;
          else
            throw SocketException("");
        }
      }
      return Right(list);
    } on DbException {
      return Left(DbFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
