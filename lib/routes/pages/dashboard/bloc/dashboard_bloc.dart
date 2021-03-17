import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../models/user.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  User _user = User();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is LoadData) {
      _user = event.user;
      yield DashboardHome();
    }
    if (event is GoToHome) yield DashboardHome();
    if (event is GoToNotes) yield DashboardNotes();
    if (event is GoToAppointments) yield DashboardAppointments();
    if (event is GoToPatients) yield DashboardPatients();
    if (event is GoToSettings) yield DashboardSettings();
  }
}
