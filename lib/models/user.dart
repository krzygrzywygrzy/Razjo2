import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({this.name, this.surname, this.email, this.token, this.role});

  final String name;
  final String surname;
  final String email;
  final String token;
  final String role;

  factory User.fromJson(Map<String, dynamic> json ){
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      token: json['token'],
      role: json['role'],
    );
  }

  Map <String, dynamic> toJson (){
    return {
      "name": name,
      "surname": surname,
      "email": email,
      "token": token,
      "role": role,
    };
  }

  @override
  List<Object> get props => [name, surname, email, token];
}