part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInital extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardHome extends DashboardState {
  DashboardHome({ @required ObjectId id}): _id = id;
  final ObjectId _id;

  @override
  List<Object> get props => [_id];

}

class DashboardNotes extends DashboardState {
  DashboardNotes({ @required ObjectId id}): _id = id;
  final ObjectId _id;

  @override
  List<Object> get props => [_id];
}

class DashboardAppointments extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardPatients extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardSettings extends DashboardState {
  @override
  List<Object> get props => [];
}


