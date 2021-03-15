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

  @override
  List<Object> get props => [];
}
