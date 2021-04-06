import 'dart:io';
import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../core/const.dart';
import '../core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import '../models/invitation.dart';
import '../models/user.dart';
import 'user_service.dart';

class InvitationService {
  /// Manages everything connected to sending, deleting, and geting list of invitations
  /// method [sendInvitation] sends new invitation
  /// method [getInvattions] gets all invitations send to user
  /// method [deleteInvitation] deletes invitation by [ObjectId]

  Db db = Db(MONGO);

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
        if (data.isRight()) {
          final User user = data.getOrElse(() => User());
          invitations.add(user);
        } else {
          throw DbException();
        }
      });
      return Right(invitations);
    } on SocketException {
      db.close();
      return Left(ConnectionFailure());
    } on DbException {
      db.close();
      return Left(
        DbFailure(),
      );
    }
  }

  Future<void> deleteInvitation(ObjectId id, String collection) async {
    try {
      await db.open();
      DbCollection coll = db.collection(collection);
      coll.remove(where.eq("from", id));
    } on SocketException {
      db.close();
    }
  }
}
