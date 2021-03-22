import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:razjo/models/contact.dart';
import 'package:razjo/services/contact_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading());

  List<Contact> contacts = [];
  ContactService _service;

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is LoadData) {
      yield DashboardLoading();
      _service = ContactService();
      var res = await _service.getContacts(event.contacts);
      if (res.isRight()) {
        contacts = (res as Right).value;
        yield DashboardHome();
      } else {
        //TODO: handle error
      }
    }
    if (event is GoToHome) yield DashboardHome();
    if (event is GoToNotes) yield DashboardNotes();
    if (event is GoToAppointments) yield DashboardAppointments();
    if (event is GoToPatients) yield DashboardPatients(contacts: contacts);
    if (event is GoToSettings) yield DashboardSettings();
  }
}
