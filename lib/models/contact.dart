import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/models/appointment.dart';
import 'note.dart';

class Contact extends Equatable {
  Contact({
    this.id,
    this.psyId,
    this.patientId,
    this.notes,
    this.psyPrivate,
    this.appointments,
    this.collection,
    this.psyName,
  });

  final ObjectId id;
  final ObjectId psyId;
  final ObjectId patientId;
  final List<Note> notes;
  final List<Note> psyPrivate;
  final List<Appointment> appointments;
  final String collection;
  final String psyName;

  factory Contact.fromJson(Map<String, dynamic> json) {
    List<Note> notesJson = [];
    if (json["notes"] != null)
      for (Map<String, dynamic> map in json["notes"])
        notesJson.add(Note.formJson(map));

    List<Note> psyPrivateJson = [];
    if (json["psyPrivate"] != null)
      for (Map<String, dynamic> map in json["psyPrivate"])
        psyPrivateJson.add(Note.formJson(map));

    List<Appointment> appointmentsJson = [];
    if (json["appointments"] != null)
      for (Map<String, dynamic> map in json["appointments"])
        appointmentsJson.add(Appointment.formJson(map));

    return Contact(
      id: json["_id"],
      psyId: json["psyId"],
      patientId: json["patientId"],
      notes: notesJson,
      psyPrivate: psyPrivateJson,
      appointments: appointmentsJson,
      collection: json["collection"],
      psyName: json["psyName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "psyId": psyId,
      "patientId": patientId,
      "notes": List<Map<String, dynamic>>.generate(
          notes.length, (index) => notes[index].toJson()),
      "psyPrivate": List<Map<String, dynamic>>.generate(
          psyPrivate.length, (index) => psyPrivate[index].toJson()),
      "appointments": List<Map<String, dynamic>>.generate(
          appointments.length, (index) => appointments[index].toJson()),
      "collection": collection,
      "psyName": psyName,
    };
  }

  @override
  List<Object> get props => [
        id,
        psyId,
        patientId,
        notes,
        psyPrivate,
        appointments,
        collection,
        psyName,
      ];
}
