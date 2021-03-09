import 'package:equatable/equatable.dart';

class User extends Equatable {
  User({this.name, this.surname, this.email, this.id, this.role});

  final String name;
  final String surname;
  final String email;
  final String id;
  final String role;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      id: json['id'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name": name,
      "surname": surname,
      "email": email,
      "role": role,
      "id": id,
    };
  }

  @override
  List<Object> get props => [name, surname, email, id, role];
}
