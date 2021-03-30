import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/core/functions/alertDialog.dart';
import 'package:razjo/models/contact_minimum.dart';
import 'package:razjo/models/note.dart';
import 'package:razjo/routes/pages/dashboard/widgets/section_top_bar.dart';
import 'package:razjo/services/note_service.dart';
import '../../../../core/const.dart';
import '../widgets/note_grid.dart';

//TODO: move some things to another file

class DashboardNotesPage extends StatefulWidget {
  DashboardNotesPage({
    @required List<Note> notes,
    @required List<ContactMinimum> contacts,
    @required String role,
    @required String name,
    Note selected,
  })  : _notes = notes,
        _contacts = contacts,
        _selected = selected,
        _role = role,
        _name = name;

  final List<Note> _notes;
  final List<ContactMinimum> _contacts;
  final Note _selected;
  final String _role;
  final String _name;

  @override
  _DashboardNotesPageState createState() => _DashboardNotesPageState();
}

class _DashboardNotesPageState extends State<DashboardNotesPage> {
  Note _currentNote;
  var _noteController = TextEditingController();
  int _selectedPsy = 0;
  int _state = 0;

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
                        onTap: () {
                          setState(() {
                            _state = 1;
                          });
                        },
                        child: Text(
                          "New",
                          style: kSubtitle,
                        ),
                      ),
                    ),
                  ],
                  alignment: MainAxisAlignment.end,
                ),
                Expanded(
                  child: buildRightSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRightSection() {
    switch (_state) {
      case 1:
        return edit();
        break;
      case 2:
        return read();
        break;
      default:
        return Center(
          child: Text("Select note to display or start editing new one"),
        );
    }
  }

  Widget read() {
    return Center();
  }

  Expanded edit() {
    return Expanded(
      child: widget._role == "USR"
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                children: [
                  widget._contacts.length > 0
                      ? Row(
                          children: [
                            Text("psychologist: "),
                            Expanded(
                              child: Container(
                                height: 20,
                                child: ListView.builder(
                                    itemCount: widget._contacts.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text(
                                            widget._contacts[index].psyName +
                                                " ",
                                            style: TextStyle(
                                              color: index == _selectedPsy
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.black,
                                              fontWeight: index == _selectedPsy
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
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
                      maxLines: 19,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        hintText: "type here...",
                        hintStyle: TextStyle(fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            var res = await _saveNote();
                            if (res.isRight()) {
                              setState(() {
                                _noteController.clear();
                                _state = 0;
                              });
                            } else {
                              // showAlertDialog(context,
                              //     "Cannot send note!\n Try again later!");
                              //TODO: repair bug
                            }
                          },
                          child: Text("Send"),
                        ),
                      ),
                    ],
                  ),
                ],
              ))
          : Center(
              child: Text("Choose note to display"),
            ),
    );
  }

  Future<dartz.Either<Failure, bool>> _saveNote() async {
    NoteService _service = NoteService();
    dartz.Either res = await _service.saveNote(
      widget._role,
      widget._contacts[_selectedPsy].collection,
      Note(
        entry: _noteController.text,
        name: widget._name,
        date: DateTime.now(),
        time: TimeOfDay.now(),
      ),
    );
    return res;
  }
}
