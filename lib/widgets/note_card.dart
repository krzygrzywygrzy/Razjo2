import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/core/functions/time_format.dart';
import 'package:razjo/models/note.dart';

class NoteCard extends StatelessWidget {
  NoteCard({@required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("dd/MM/yyy").format(note.date);

    return Container(
      decoration: BoxDecoration(
        border: kBottomBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${note.name}",
            style: kSubtitle,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                note.patientEntry,
                style: TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
              ),
            ),
          ),
          Text(
            "$formattedDate ${formatTime(note.time.hour)}:${formatTime(note.time.minute)}",
            style: TextStyle(
              fontSize: 12,
              color: kLightGrayAccent,
            ),
          ),
        ],
      ),
    );
  }
}
