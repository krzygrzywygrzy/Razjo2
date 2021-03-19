import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

//TODO:
class Invitation extends Equatable {
  Invitation({
    this.from,
    this.type,
  });
  final ObjectId from;
  final String type;

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      from: json["from"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "from": from,
      "type": type,
    };
  }

  @override
  List<Object> get props => [from, type];

  @override
  bool get stringify => false;
}
