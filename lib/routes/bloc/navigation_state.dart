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
  @override
  List<Object> get props => [];
}

class NavigationSignUp extends NavigationState {
  @override
  List<Object> get props => [];
}

class NavigationDashboard extends NavigationState {
  NavigationDashboard({@required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}
