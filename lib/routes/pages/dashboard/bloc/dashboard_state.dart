part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardHome extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardNotes extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardAppointments extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardPatients extends DashboardState {
  DashboardPatients({@required this.contacts});
  final List<Contact> contacts;

  @override
  List<Object> get props => [contacts];
}

class DashboardSettings extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object> get props => [];
}
