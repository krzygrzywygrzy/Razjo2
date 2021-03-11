import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/routes/pages/dashboard/widgets/note_grid.dart';
import 'package:razjo/services/note_service.dart';

class DashboardNotesPage extends StatelessWidget {
  DashboardNotesPage({@required ObjectId objectId}) : _objectId = objectId;
  final ObjectId _objectId;

  @override
  Widget build(BuildContext context) {
    NoteService _noteService = NoteService();

    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: kRightBorder),
              child: NoteGird(
                noteService: _noteService,
                objectId: _objectId,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
