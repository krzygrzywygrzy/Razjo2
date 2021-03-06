import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({this.name, this.surname, this.email, this.token});

  final String name;
  final String surname;
  final String email;
  final String token;

  factory User.fromJson(Map<String, dynamic> json ){
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map <String, dynamic> toJson (){
    return {
      "name": name,
      "surname": surname,
      "email": email,
      "token": token,
    };
  }

  @override
  List<Object> get props => [name, surname, email, token];
}