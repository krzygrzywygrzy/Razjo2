import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class LocalDataSourceFailure implements Failure {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => null;
}

class ConnectionFailure implements Failure {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => null;
}

class EmailFailure implements Failure {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => null;
}

class SignUpFailure implements Failure {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => null;
}

class DbFailure implements Failure {
  DbFailure({this.message});
  final String message;

  @override
  List<Object> get props => [message];
  @override
  bool get stringify => null;
}

class LogInFailure implements Failure {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => null;
}
