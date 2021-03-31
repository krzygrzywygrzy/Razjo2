import 'package:flutter/material.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/models/appointment.dart';
import 'package:razjo/models/contact_minimum.dart';
import 'package:razjo/routes/pages/dashboard/widgets/section_top_bar.dart';
import 'package:razjo/widgets/appointment_card.dart';

class DashboardAppointmentsPage extends StatefulWidget {
  final List<Appointment> _appointments;
  final List<ContactMinimum> _contacts;

  const DashboardAppointmentsPage({
    Key key,
    @required List<Appointment> appointments,
    @required List<ContactMinimum> contacts,
  })  : _appointments = appointments,
        _contacts = contacts,
        super(key: key);

  @override
  _DashboardAppointmentsPageState createState() =>
      _DashboardAppointmentsPageState();
}

class _DashboardAppointmentsPageState extends State<DashboardAppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(border: kRightBorder),
            child: Column(
              children: [
                SectionTopBar(
                  children: [
                    Text(
                      "Appointments",
                      style: kSubtitle,
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    child: Container(
                      child: widget._appointments.length > 0
                          ? ListView.builder(
                              itemCount: widget._appointments.length,
                              itemBuilder: (context, index) {
                                return AppointmentCard(
                                  appointment: widget._appointments[index],
                                );
                              },
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Nothing here yet!"),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              SectionTopBar(
                children: [
                  Text("Add appointment", style: kSubtitle),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      child: Container(
                        child: Placeholder(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        color: Colors.blue,
                        child: Placeholder(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
