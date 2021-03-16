import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../core/erros/exceptions.dart';
import '../core/erros/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

const LOCAL_DATA_STRING = "LOCAL_USER";

class LocalStorageService {
  ///Manages to save and load data from local storage
  ///
  /// Throws [LocalDataSourceException] when cannot read data

  SharedPreferences _sharedPreferences;

  Future<Either<Failure, Map<String, dynamic>>> getLocalData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      var json = jsonDecode(_sharedPreferences.getString(LOCAL_DATA_STRING));
      if (json != null)
        return Right(json);
      else
        throw LocalDataSourceException();
    } on LocalDataSourceException {
      return Left(LocalDataSourceFailure());
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveToLocal(Map<String, dynamic> dataToSave) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString(
        LOCAL_DATA_STRING, jsonEncode(dataToSave));
  }
}
