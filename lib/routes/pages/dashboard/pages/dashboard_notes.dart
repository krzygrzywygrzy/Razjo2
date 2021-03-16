import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(border: kBottomBorder),
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit note",
                          style: kSubtitle,
                        ),
                        Text(
                          "Save",
                          style: kSubtitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
