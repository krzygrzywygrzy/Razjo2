import 'package:dartz/dartz.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/exceptions.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/login_data.dart';
import 'package:razjo/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/services/local_storage_service.dart';

class AuthenticationService {
  ///Manages login and registration
  ///
  /// Throws [EmailException] when email is in the database
  /// Throws [SignUpException] when there is problem while adding user to database
  /// Catches [Exception] when unable to connect to the database

  Db db = Db(MONGO);

  Future<Either<Failure, User>> userLogin(email, password) async {
    LocalStorageService _localStorage = LocalStorageService();
    try {
      await db.open();
      DbCollection collection = db.collection("users");

      var data = await collection.findOne({
        "email": email,
        "password": password,
      });
      if (data != null) {
        LoginData cacheData = LoginData(email: email, password: password);
        _localStorage.saveToLocal(cacheData.toJson());
        return Right(User.fromJson(data));
      } else throw LogInException();
    } catch (_) {
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
      if (res["err"] == null) {
        return this.userLogin(user["email"], user["password"]);
      } else {
        throw SignUpException();
      }
    } on EmailException {
      return Left(EmailFailure());
    } on SignUpException {
      return Left(SignUpFailure());
    } catch (_) {
      return Left(ConnectionFailure());
    }
  }
}
