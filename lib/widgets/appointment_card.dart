import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  AppointmentCard({@required this.appointment});
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("dd/MM/yyy").format(appointment.date);

    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: kBottomBorder),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${appointment.name} ${appointment.surname}",
            style: TextStyle(
              color: kDark,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              Text(
                "${formattedDate}",
                style: TextStyle(
                  color: kLightGrayAccent,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.access_time_outlined,
                color: kLightGrayAccent,
                size: 14,
              ),
              Text(
                " ${appointment.time.hour}:${appointment.time.hour}",
                style: TextStyle(
                  color: kLightGrayAccent,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
