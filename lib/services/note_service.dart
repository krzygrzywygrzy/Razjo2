import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../core/const.dart';
import '../core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import '../models/note.dart';

class NoteService {
  Db db = Db(MONGO);

  //TODO: error handling
  Future<Either<Failure, bool>> saveNote(
      String role, String collection, Note note) async {
    try {
      await db.open();
      var res = await db.collection(collection).update(
          where.exists("collection"),
          modify.push(
            role == "PSY" ? "psyPrivate" : "notes",
            note.toJson(),
          ));
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
        DbFailure(message: "Cannot send note!"),
      );
    }
  }

  Future<Either<Failure, bool>> deleteNote() async {
    throw UnimplementedError();
  }
}
