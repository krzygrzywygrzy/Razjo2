import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User extends Equatable {
  User({
    this.name,
    this.surname,
    this.email,
    this.id,
    this.role,
    this.contacts,
    this.avatar,
    this.notifications,
    this.description,
    this.messages,
  });

  final String name;
  final String surname;
  final String email;
  final ObjectId id;
  final String role;
  final String avatar;
  final String description;
  final List<String> contacts;
  final String notifications;
  final String messages;

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> contactsJson = [];
    for (String str in json["contacts"]) contactsJson.add(str);

    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      id: json['_id'],
      role: json['role'],
      avatar: json['avatar'],
      contacts: contactsJson,
      notifications: json["notifications"],
      messages: json["messasges"],
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
    return map;
  }

  @override
  List<Object> get props => [name, surname, email, id, role, avatar, contacts];
}
