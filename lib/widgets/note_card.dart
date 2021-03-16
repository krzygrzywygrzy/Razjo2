import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../core/const.dart';
import '../core/functions/time_format.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  NoteCard({@required Note note}) : _note = note;
  final Note _note;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("dd/MM/yyy").format(_note.date);

    return Container(
      decoration: BoxDecoration(
        border: kBottomBorder,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${_note.name}",
            style: kSubtitle,
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                _note.patientEntry,
                style: TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
              ),
            ),
          ),
          Text(
            "$formattedDate ${formatTime(_note.time.hour)}:${formatTime(_note.time.minute)}",
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
