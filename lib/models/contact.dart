import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Contact extends Equatable {
  Contact({
    this.id,
    this.psyId,
    this.patientId,
  });

  final ObjectId id;
  final ObjectId psyId;
  final ObjectId patientId;

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json["id"],
      psyId: json["psyId"],
      patientId: json["patientId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "psyId": psyId,
      "patientId": patientId,
    };
  }

  @override
  List<Object> get props => [id, psyId, patientId];
}
