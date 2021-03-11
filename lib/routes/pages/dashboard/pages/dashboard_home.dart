import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/appointment.dart';
import 'package:razjo/routes/pages/dashboard/widgets/note_grid.dart';
import 'package:razjo/services/appointment_service.dart';
import 'package:razjo/services/note_service.dart';
import 'package:razjo/widgets/appointment_card.dart';


class DashboardHomePage extends StatelessWidget {
  DashboardHomePage({@required ObjectId objectId}): _objectId = objectId;
  final ObjectId _objectId;

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
          child: NoteGird(
            noteService: _noteService,
            objectId: _objectId,
          ),
        ),
      ],
    );
  }
}
