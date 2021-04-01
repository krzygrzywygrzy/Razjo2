import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ContactMinimum extends Equatable {
  ContactMinimum({
    @required this.psyName,
    @required this.collection,
    @required this.name,
  });

  final String psyName;
  final String name;
  final String collection;

  @override
  List<Object> get props => [psyName, collection, name];
}
