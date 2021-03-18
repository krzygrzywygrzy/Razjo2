import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../models/user.dart';
import '../../../../models/invitation.dart' as model;

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());

  // ignore: close_sinks
  StreamController<List<model.Notification>> _notificationController =
      StreamController();
  Stream get notificationStream => _notificationController.stream;
  Sink get notificationSink => _notificationController.sink;

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is LoadData) {
      yield DashboardHome();
    }
    if (event is GoToHome) yield DashboardHome();
    if (event is GoToNotes) yield DashboardNotes();
    if (event is GoToAppointments) yield DashboardAppointments();
    if (event is GoToPatients) yield DashboardPatients();
    if (event is GoToSettings) yield DashboardSettings();
    if (event is GoToMessages) yield DashboardMessages();
    if (event is GoToNotifications) yield DashboardNotifications();
  }
}
