import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/functions/time_format.dart';
import 'package:razjo/core/functions/time_picker.dart';
import 'package:razjo/models/appointment.dart';
import 'package:razjo/models/contact_minimum.dart';
import 'package:razjo/routes/pages/dashboard/widgets/section_top_bar.dart';
import 'package:razjo/services/appointment_service.dart';
import 'package:razjo/widgets/appointment_card.dart';

class DashboardAppointmentsPage extends StatefulWidget {
  final List<Appointment> _appointments;
  final List<ContactMinimum> _contacts;
  final String _role;

  const DashboardAppointmentsPage({
    Key key,
    @required List<Appointment> appointments,
    @required List<ContactMinimum> contacts,
    @required String role,
  })  : _appointments = appointments,
        _contacts = contacts,
        _role = role,
        super(key: key);

  @override
  _DashboardAppointmentsPageState createState() =>
      _DashboardAppointmentsPageState();
}

class _DashboardAppointmentsPageState extends State<DashboardAppointmentsPage> {
  int _selected = 0;
  DateTime _date;
  TimeOfDay _time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
          child: Column(
            children: [
              SectionTopBar(
                children: [
                  Text("Add appointment", style: kSubtitle),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget._role == "PSY"
                          ? "Patients:"
                          : "Psychologists:"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Container(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget._contacts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selected = index;
                                    });
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      widget._contacts[index].psyName + "  ",
                                      style: TextStyle(
                                        color: index == _selected
                                            ? Theme.of(context).primaryColor
                                            : Colors.black,
                                        fontWeight: index == _selected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    Text("Date: "),
                    GestureDetector(
                      onTap: () async {
                        var newDate = await pickDate(context);
                        setState(() {
                          _date = newDate;
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(_date != null
                            ? DateFormat("dd/MM/yyy").format(_date)
                            : "not specified"),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text("Time: "),
                    GestureDetector(
                      onTap: () async {
                        var newTime = await pickTime(context);
                        setState(() {
                          _time = newTime;
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(_time != null
                            ? '${formatTime(_time.hour)}:${formatTime(_time.minute)}'
                            : "not specified"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(border: kBottomBorder),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (_date != null && _time != null) {
                            AppointmentService _service = AppointmentService();
                            _service.addAppointment(
                                //TODO: add names and surnames to appointment
                                Appointment(
                                  date: _date,
                                  time: _time,
                                ),
                                widget._contacts[_selected].collection);
                          }
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text("Add"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
