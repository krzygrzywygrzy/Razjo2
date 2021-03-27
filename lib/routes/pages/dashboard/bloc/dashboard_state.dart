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
  DashboardNotes({this.notes, this.contacts});
  final List<Note> notes;
  final List<ContactMinimum> contacts;

  @override
  List<Object> get props => [notes, contacts];
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
