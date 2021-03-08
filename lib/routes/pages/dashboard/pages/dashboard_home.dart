import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/appointment.dart';
import 'package:razjo/models/note.dart';
import 'package:razjo/services/appointment_service.dart';
import 'package:razjo/services/note_service.dart';
import 'package:razjo/widgets/appointment_card.dart';
import 'package:razjo/widgets/note_card.dart';

class DashboardHomePage extends StatelessWidget {
  AppointmentService _appointmentService = AppointmentService();
  NoteService _noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: kRightBorder,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ///
                /// Section title
                ///
                Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: kBottomBorder,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Recent Appointments",
                          style: kSubtitle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),

                ///
                /// List of appointments
                ///
                FutureBuilder(
                  future: _appointmentService.getAppointments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Either<Failure, List<Appointment>>>
                          snapshot) {
                    if (snapshot.hasData && snapshot.data.isRight()) {
                      List<Appointment> _list =
                          snapshot.data.getOrElse(() => <Appointment>[]);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10),
                          child: Container(
                            child: ListView.builder(
                              itemCount: _list.length,
                              itemBuilder: (context, index) {
                                return AppointmentCard(
                                    appointment: _list[index]);
                              },
                            ),
                          ),
                        ),
                      );
                    } else
                      return Text("Loading");
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ///
                /// Title section + search bar
                ///
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notes",
                        style: kSubtitle,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Icon(
                          Icons.search,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  height: 40,
                  decoration: BoxDecoration(
                    border: kBottomBorder,
                  ),
                ),

                ///
                ///  Notes section
                ///
                FutureBuilder(
                  future: _noteService.getNotes(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Either<Failure, List<Note>>> snapshot) {
                    if (snapshot.hasData && snapshot.data.isRight()) {
                      List<Note> _notes =
                          snapshot.data.getOrElse(() => <Note>[]);
                      return Expanded(
                          child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: _notes.length,
                          itemBuilder: (context, index) {
                            return NoteCard(
                              note: _notes[index],
                            );
                          },
                        ),
                      ));
                    } else
                      return Text("loading...");
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
