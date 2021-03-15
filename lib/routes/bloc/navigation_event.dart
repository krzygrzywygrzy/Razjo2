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
  LogInEvent({this.password, this.email});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class GoToSignUpScreen extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class SignUpEvent extends NavigationEvent {
  SignUpEvent({this.user});
  final Map<String, dynamic> user;

  @override
  List<Object> get props => [user];
}

class LogOutEvent extends NavigationEvent {
  @override
  List<Object> get props => [];
}