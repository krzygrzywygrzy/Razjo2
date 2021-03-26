import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:razjo/models/note.dart';
import 'package:razjo/routes/pages/dashboard/widgets/section_top_bar.dart';
import 'package:razjo/widgets/outline_button.dart';
import '../../../../core/const.dart';
import '../widgets/note_grid.dart';
import '../../../../services/note_service.dart';

class DashboardNotesPage extends StatefulWidget {
  DashboardNotesPage({@required mongo.ObjectId id}) : _id = id;
  final mongo.ObjectId _id;

  @override
  _DashboardNotesPageState createState() => _DashboardNotesPageState();
}

class _DashboardNotesPageState extends State<DashboardNotesPage> {
  Note _currentNote;

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
                objectId: widget._id,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SectionTopBar(
                  children: [
                    Text(
                      "Note",
                      style: kSubtitle,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Text(
                          _currentNote == null ? "New" : "Save",
                          style: kSubtitle,
                        ),
                      ),
                    ),
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
                ),
                edit(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded edit() => Expanded(
        child: _currentNote == null
            ? Center(
                child: MyOutlineButton(
                  label: "Create new note",
                ),
              )
            : Container(),
      );
}
