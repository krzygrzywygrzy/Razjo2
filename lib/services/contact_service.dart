import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/exceptions.dart';
import 'package:razjo/core/erros/failures.dart';

class ContactService {
  ///Manages to add, delete and read data from "contacts"

  Db db = Db(MONGO);
  Future<Either<Failure, void>> addContact(
      ObjectId psychologist, ObjectId patient) async {
    try {} on DbException {} on SocketException {}
  }
}
