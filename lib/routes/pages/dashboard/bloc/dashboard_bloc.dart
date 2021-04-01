import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:razjo/models/appointment.dart';
import 'package:razjo/models/contact.dart';
import 'package:razjo/models/contact_minimum.dart';
import 'package:razjo/models/note.dart';
import 'package:razjo/services/contact_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading());

  List<Contact> contacts = [];
  ContactService _service;
  List<String> sContacts = [];

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is LoadData) {
      yield DashboardLoading();
      sContacts = event.contacts;
      _service = ContactService();
      var res = await _service.getContacts(event.contacts);
      if (res.isRight()) {
        contacts = (res as Right).value;
        yield DashboardHome(_getNotes(), _getAppointments());
      } else {
        //TODO: handle error
      }
    }
    if (event is GoToHome) yield DashboardHome(_getNotes(), _getAppointments());
    if (event is GoToNotes)
      yield DashboardNotes(
          notes: _getNotes(),
          contacts: _getMinContacts(),
          selected: event.note);
    if (event is GoToAppointments)
      yield DashboardAppointments(
          appointments: _getAppointments(), contacts: _getMinContacts());
    if (event is GoToPatients) yield DashboardPatients(contacts: contacts);
    if (event is GoToSettings) yield DashboardSettings();

    if (event is ReloadData) {
      _service = ContactService();
      var res = await _service.getContacts(sContacts);
      if (res.isRight()) {
        contacts = (res as Right).value;
      } else {
        yield DashboardError();
      }
    }
  }

  List<Note> _getNotes() {
    List<Note> list = [];
    if (contacts != null) {
      for (var contact in contacts)
        for (var note in contact.notes) list.add(note);
    }
    return list;
  }

  List<ContactMinimum> _getMinContacts() {
    List<ContactMinimum> list = [];
    if (contacts != null) {
      for (var contact in contacts) {
        list.add(
          ContactMinimum(
            psyName: contact.psyName,
            collection: contact.collection,
            name: contact.name,
          ),
        );
      }
    }
    return list;
  }

  List<Appointment> _getAppointments() {
    List<Appointment> list = [];
    if (contacts != null) {
      for (var contact in contacts) {
        for (var appointment in contact.appointments) list.add(appointment);
      }
    }
    return list;
  }
}
