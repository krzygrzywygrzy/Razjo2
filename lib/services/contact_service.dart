import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:uuid/uuid.dart';

import '../core/const.dart';
import '../core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import '../models/contact.dart';
import 'user_service.dart';

class ContactService {
  ///Manages to add, delete and read data from "contacts" list
  /// [addContact] adds contacts to contacts list
  /// [getContacts] gets list of contacts
  /// [removeContact] removes contact (not fully implemented yet!)

  Db db = Db(MONGO);
  Future<Either<Failure, bool>> addContact(ObjectId psychologist,
      ObjectId patient, String psyName, String name) async {
    try {
      final String contactCollection = "contact-${Uuid().v4()}";
      Contact contact = Contact(
        patientId: patient,
        psyId: psychologist,
        notes: [],
        psyPrivate: [],
        appointments: [],
        collection: contactCollection,
        psyName: psyName,
      );
      await db.open();
      DbCollection coll = db.collection(contactCollection);
      var response = await coll.insertOne(contact.toJson());
      if (response["\$err"] == null) {
        UserService service = UserService();
        final psy = await service.editArray(
            psychologist, "contacts", contactCollection);
        final usr =
            await service.editArray(patient, "contacts", contactCollection);

        if (psy.isRight() && usr.isRight()) {
          db.close();
          return Right(true);
        } else
          throw DbException();
      } else
        throw DbException();
    } on DbException {
      db.close();
      return Left(DbFailure());
    } on SocketException {
      db.close();
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, List<Contact>>> getContacts(
      List<String> collections) async {
    List<Contact> list = [];
    try {
      await db.open();
      for (String coll in collections) {
        var res = await db.collection(coll).find().single;
        if (res["err"] == null) {
          list.add(Contact.fromJson(res));
        } else
          throw DbException();
      }
      return Right(list);
    } on DbException {
      return Left(DbFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, bool>> removeContact(
      String coll, List<ObjectId> users) async {
    try {
      await db.open();
      for (ObjectId id in users) {
        var res = await db
            .collection("users")
            .findOne(where.id(id).fields(["contacts"]));
        print(res);
      }
    } on DbException {
      db.close();
      return Left(DbFailure());
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }
}
