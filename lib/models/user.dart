import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/models/invitation.dart';
import 'contact.dart';

class User extends Equatable {
  User({
    this.name,
    this.surname,
    this.email,
    this.id,
    this.role,
    this.contacts,
    this.avatar,
    this.invatations,
  });

  final String name;
  final String surname;
  final String email;
  final ObjectId id;
  final String role;
  final String avatar;
  final List<Contact> contacts;
  final List<Inviataion> invatations;

  factory User.fromJson(Map<String, dynamic> json) {
    List<Contact> contactsJson = [];
    for (Map<String, dynamic> map in json["contacts"]) {
      contactsJson.add(Contact.fromJson(map));
    }

    List<Inviataion> invitationsJson = [];
    for (Map<String, dynamic> map in json["invitation"]) {
      invitationsJson.add(Inviataion.fromJson(map));
    }

    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      id: json['_id'],
      role: json['role'],
      avatar: json['avatar'],
      contacts: contactsJson,
      invatations: invitationsJson,
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
  List<Object> get props => [name, surname, email, id, role, avatar, contacts];
}
