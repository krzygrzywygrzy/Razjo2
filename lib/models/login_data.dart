import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginData extends Equatable {
  LoginData({@required this.email, @required this.password});
  final String email;
  final String password;

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson (){
    return {
      "email": email,
      "password": password,
    };
  }

  @override
  List<Object> get props => [email, password];
}
