import 'package:dartz/dartz.dart';
import '../core/const.dart';
import '../core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import '../models/login_data.dart';
import '../models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'local_storage_service.dart';
import 'package:uuid/uuid.dart';

class AuthenticationService {
  ///Manages login and registration
  ///
  /// Throws [EmailException] when email is in the database
  /// Throws [SignUpException] when there is problem while adding user to database
  /// Throws [LogInException] when there is problem with login
  /// Catches [Exception] when unable to connect to the database
  ///
  ///
  /// TODO: use Mongo Authorization
  ///
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
      } else
        throw LogInException();
    } catch (e) {
      return Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, User>> userSignUp(Map<String, dynamic> user) async {
    try {
      await db.open();
      DbCollection collection = db.collection("users");

      var emailCheck = await collection.findOne({"email": user["email"]});
      if (emailCheck != null) throw EmailException();

      //adding some nessesary fields
      String uuid = Uuid().v4();
      user["contacts"] = [];
      user["notifications"] = 'notifications-$uuid';
      user["avatar"] = "";

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
    } catch (e) {
      return Left(ConnectionFailure());
    }
  }
}
