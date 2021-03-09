import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/exceptions.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AuthenticationService {
  Db db = Db(MONGO);

  Future<Either<Failure, User>> userLogin(email, password) async {
    try {
      await db.open();
      return Right(
        User(id: "123", name: "Oli", surname: "Sykes", role: "USR"),
      );
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, User>> userSignUp(Map<String, dynamic> user) async {
    try {
      await db.open();
      DbCollection collection = db.collection("users");

      var emailCheck = await collection.findOne({"email": user["email"]});
      if (emailCheck != null) throw EmailException();

      var res = await collection.insert(user);
      if(res["err"] == null) {
        //TODO: get instance from db and return User
      }

    }  on EmailException {
      return Left(EmailFailure());
    } catch (_){
      return Left(ConnectionFailure());
    }
  }

}
