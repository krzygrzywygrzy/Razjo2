part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class CheckAuthentication extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class GoToLogInScreen extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class LogInEvent extends NavigationEvent {
  LogInEvent({this.password, this.login});

  final String login;
  final String password;

  @override
  List<Object> get props => [login, password];
}

class GoToSignUpScreen extends NavigationEvent {
  @override
  List<Object> get props => [];
}
