import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../core/const.dart';
import '../core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import '../models/note.dart';

class NoteService {
  /// Manages everything related to notes correspondence
  /// [saveNote] manages saving note to notes list
  /// [deleteNote] manges deleting note

  Db db = Db(MONGO);

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
      db.close();
      if (res["err"] == null) {
        return Right(true);
      } else
        throw DbException();
    } on SocketException {
      return Left(ConnectionFailure());
    } on DbException {
      return Left(
        DbFailure(),
      );
    }
  }

  Future<Either<Failure, bool>> deleteNote() async {
    throw UnimplementedError();
  }
}
