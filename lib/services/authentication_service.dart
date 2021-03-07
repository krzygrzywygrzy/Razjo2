import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/user.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<Either<Failure, User>> userLogin(login, password) async {
    try {
      // var json = jsonEncode({"login": login, "password": password});
      // var response = await http.post(
      //   Uri.http(API_URL, "/login"),
      //   body: json,
      //   headers: {
      //     "ContentType": "applicaion/json",
      //   },
      // );
        return Right(
          User(token: "123"),
        );
    } on SocketException {
      return Left(ConnectionFailure());
    }
  }

}
