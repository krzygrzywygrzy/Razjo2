import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/const.dart';
import '../../../../models/appointment.dart';
import '../../../../models/note.dart';
import '../../../../widgets/appointment_card.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/note_grid.dart';

// ignore: must_be_immutable
class DashboardHomePage extends StatelessWidget {
  final List<Appointment> appointments;
  final List<Note> notes;

  const DashboardHomePage(
      {Key key, @required this.appointments, @required this.notes})
      : super(key: key);

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
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Container(
                      child: appointments.length > 0
                          ? ListView.builder(
                              itemCount: appointments.length,
                              itemBuilder: (context, index) {
                                return AppointmentCard(
                                    appointment: appointments[index], role: "");
                              },
                            )
                          : Center(
                              child: Text("Nothing here yet!"),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: NoteGird(
            notes: notes,
            display: (index) {
              context.read<DashboardBloc>().add(GoToNotes(note: notes[index]));
            },
          ),
        ),
      ],
    );
  }
}
