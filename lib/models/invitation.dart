import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Invitation extends Equatable {
  Invitation({
    this.from,
    this.id,
  });
  final ObjectId from;
  final ObjectId id;

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      from: json["from"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "from": from,
    };
  }

  @override
  List<Object> get props => [from, id];

  @override
  bool get stringify => false;
}
