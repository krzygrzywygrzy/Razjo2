import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:razjo/models/login_data.dart';

void main() {
  final tLoginData = LoginData(email: "email", password: "password");

  test("should return a valid LoginData model when json is provided", () {
    //arrange
    var json = '{"email": "email", "password": "password"}';
    final Map<String, dynamic> jsonMap = jsonDecode(json);
    //act
    final result = LoginData.fromJson(jsonMap);
    //assert
    expect(result, tLoginData);
  });

  test("should return JSON map from LoginData model containing proper data",
      () {
    //act
    final result = tLoginData.toJson();
    //assert
    final expectedMap = {"email": "email", "password": "password"};
    expect(result, expectedMap);
  });
}
