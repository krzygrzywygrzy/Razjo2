import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'message.dart';

class MessageCollection extends Equatable {
  MessageCollection({
    this.messages,
    this.users,
  });

  final List<Message> messages;
  final List<ObjectId> users;

  @override
  List<Object> get props => [messages, users];
}
