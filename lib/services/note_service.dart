import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/exceptions.dart';
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
      if (res["err"] == null)
        return Right(true);
      else
        throw DbException();
    } on SocketException {} on DbException {}
  }

  Future<Either<Failure, bool>> deleteNote() async {
    throw UnimplementedError();
  }
}
