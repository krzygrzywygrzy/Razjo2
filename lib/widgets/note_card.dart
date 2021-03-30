import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../core/const.dart';
import '../core/functions/time_format.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  NoteCard({@required Note note, Function onTap})
      : _note = note,
        _onTap = onTap;
  final Note _note;
  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("dd/MM/yyy").format(_note.date);

    return Container(
      decoration: BoxDecoration(
        border: kBottomBorder,
      ),
      child: GestureDetector(
        onTap: _onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  "${_note.name}",
                  style: kSubtitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  _note.entry,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 7,
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
        ),
      ),
    );
  }
}
