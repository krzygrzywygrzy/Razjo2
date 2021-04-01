import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../core/const.dart';
import '../core/functions/time_format.dart';
import '../models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  AppointmentCard({@required Appointment appointment})
      : _appointment = appointment;
  final Appointment _appointment;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("dd/MM/yyy").format(_appointment.date);

    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: kBottomBorder),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${_appointment.name}",
              style: TextStyle(
                color: kDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Text(
                  "$formattedDate",
                  style: TextStyle(
                    color: kLightGrayAccent,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
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
                  " ${formatTime(_appointment.time.hour)}:${formatTime(_appointment.time.minute)}",
                  style: TextStyle(
                    color: kLightGrayAccent,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
