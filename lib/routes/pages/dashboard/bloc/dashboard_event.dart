part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class LoadData extends DashboardEvent {
  LoadData({@required this.contacts});
  final List<String> contacts;
  @override
  List<Object> get props => [contacts];
}

class GoToHome extends DashboardEvent {
  @override
  List<Object> get props => [];
}

class GoToNotes extends DashboardEvent {
  final Note note;

  GoToNotes({this.note});

  @override
  List<Object> get props => [note];
}

class GoToAppointments extends DashboardEvent {
  @override
  List<Object> get props => [];
}

class GoToPatients extends DashboardEvent {
  @override
  List<Object> get props => [];
}

class GoToSettings extends DashboardEvent {
  @override
  List<Object> get props => [];
}

class ReloadData extends DashboardEvent {
  @override
  List<Object> get props => [];
}
