import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'contact.dart';

class User extends Equatable {
  User(
      {this.name, this.surname, this.email, this.id, this.role, this.contacts});

  final String name;
  final String surname;
  final String email;
  final ObjectId id;
  final String role;
  final List<Contact> contacts;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      id: json['_id'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name": name,
      "surname": surname,
      "email": email,
      "role": role,
      "_id": id,
    };
  }

  @override
  List<Object> get props => [name, surname, email, id, role, contacts];
}
