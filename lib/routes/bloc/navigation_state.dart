part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationInitial extends NavigationState {
  @override
  List<Object> get props => [];
}

class NavigationLoading extends NavigationState {
  @override
  List<Object> get props => [];
}

class NavigationLogIn extends NavigationState {
  final Failure failure;
  NavigationLogIn({this.failure});

  @override
  List<Object> get props => [failure];
}

class NavigationSignUp extends NavigationState {
  final Failure failure;
  NavigationSignUp({this.failure});

  @override
  List<Object> get props => [failure];
}

class NavigationDashboard extends NavigationState {
  NavigationDashboard({@required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}
