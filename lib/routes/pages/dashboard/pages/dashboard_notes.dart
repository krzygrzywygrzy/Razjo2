import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:razjo/models/contact_minimum.dart';
import 'package:razjo/models/note.dart';
import 'package:razjo/routes/pages/dashboard/widgets/section_top_bar.dart';
import '../../../../core/const.dart';
import '../widgets/note_grid.dart';

class DashboardNotesPage extends StatefulWidget {
  DashboardNotesPage({
    @required List<Note> notes,
    @required List<ContactMinimum> contacts,
    @required String role,
    Note selected,
  })  : _notes = notes,
        _contacts = contacts,
        _selected = selected,
        _role = role;

  final List<Note> _notes;
  final List<ContactMinimum> _contacts;
  final Note _selected;
  final String _role;

  @override
  _DashboardNotesPageState createState() => _DashboardNotesPageState();
}

class _DashboardNotesPageState extends State<DashboardNotesPage> {
  Note _currentNote;
  var _noteController = TextEditingController();

  @override
  void initState() {
    if (widget._selected != null) {
      //TODO: make note instanty displaied
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: kRightBorder),
              child: NoteGird(
                notes: widget._notes,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SectionTopBar(
                  children: [
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
                  alignment: MainAxisAlignment.end,
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
        child: widget._role == "USR"
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: Column(
                  children: [
                    widget._contacts.length > 0
                        ? Row(
                            children: [
                              Text("psychologist: "),
                              Container(
                                child: ListView.builder(
                                  itemCount: widget._contacts.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: Text(
                                        widget._contacts[index].psyName,
                                      ),
                                    );
                                  },
                                ),
                                height: 40,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                  "No psychologists to select.\nChanges won't be saved!"),
                            ],
                          ),
                    SizedBox(height: 8),
                    Expanded(
                      child: TextField(
                        controller: _noteController,
                        style: TextStyle(fontSize: 13),
                        minLines: 1,
                        maxLines: 20,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          hintText: "type here...",
                          hintStyle: TextStyle(fontSize: 13),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text("Choose note to display"),
              ),
      );
}
