import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:razjo/core/erros/exceptions.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const LOCAL_DATA_STRING = "LOCAL_USER";

class LocalStorageService {
  ///Manages to save and load data from local storage
  ///
  /// Throws [LocalDataSourceException] when cannot read data

  SharedPreferences _sharedPreferences;

  Future<Either<Failure, User>> getLocalData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      var json =
          jsonDecode(await _sharedPreferences.getString(LOCAL_DATA_STRING));
      if (json != null) {
        return Right(User.fromJson(json));
      } else
        throw LocalDataSourceException();
    } on LocalDataSourceException {
      return Left(LocalDataSourceFailure());
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveToLocal(User save) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString(
        LOCAL_DATA_STRING, jsonEncode(save.toJson()));
  }
}
