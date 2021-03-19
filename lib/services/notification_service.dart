import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/exceptions.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/invitation.dart';
import 'package:razjo/models/user.dart';
import 'package:razjo/services/user_service.dart';

class InvitationService {
  Db db = Db(MONGO);
  //TODO: error handling

  Future<void> sendInviataion(String collection, Invitation invitation) async {
    try {
      await db.open();
      DbCollection coll = db.collection(collection);
      coll.insertOne(invitation.toJson());
      await db.close();
    } catch (_) {}
  }

  Future<Either<Failure, List<User>>> getInvitations(String collection) async {
    try {
      await db.open();
      DbCollection coll = db.collection(collection);
      var response = await coll.find().toList();

      List<User> invitations = [];
      UserService _userService = UserService();
      response.forEach((element) async {
        var data = await _userService.getUser(element["from"]);
        if (data.isRight())
          invitations.add(data.getOrElse(() => User()));
        else
          return (data as Left).value;
      });
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
