import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/core/functions/alertDialog.dart';
import 'package:razjo/core/functions/time_format.dart';
import 'package:razjo/models/contact_minimum.dart';
import 'package:razjo/models/note.dart';
import 'package:razjo/routes/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:razjo/routes/pages/dashboard/widgets/section_top_bar.dart';
import 'package:razjo/services/note_service.dart';
import '../../../../core/const.dart';
import '../widgets/note_grid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int _state = 0; // 0 -> none; 1-> editing 2 -> displaying

  @override
  void initState() {
    if (widget._selected != null) {
      _currentNote = widget._selected;
      setState(() {
        _state = 2;
      });
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
                display: (index) {
                  setState(() {
                    _currentNote = widget._notes[index];
                    _state = 2;
                  });
                },
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
                          if (widget._role != "PSY" && _state != 1) {
                            _noteController.clear();
                            setState(() {
                              _state = 1;
                            });
                          }
                        },
                        child: Text(
                          widget._role != "PSY" ? "New" : "",
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

  // ignore: missing_return
  Widget buildRightSection() {
    switch (_state) {
      case 1:
        if (widget._role != "PSY")
          return edit();
        else
          setState(() {
            _state = 0;
          });
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
    String formattedDate = DateFormat("dd/MM/yyy").format(_currentNote.date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentNote.name,
                style: kSubtitle,
              ),
              Text(
                "$formattedDate ${formatTime(_currentNote.time.hour)}:${formatTime(_currentNote.time.minute)}",
              ),
            ],
          ),
          SizedBox(height: 40),
          Expanded(
            child: Text(_currentNote.entry != ""
                ? _currentNote.entry
                : "This note is empty!"),
          ),
        ],
      ),
    );
  }

  Widget edit() {
    return Padding(
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
                                      widget._contacts[index].psyName + " ",
                                      style: TextStyle(
                                        color: index == _selectedPsy
                                            ? Theme.of(context).primaryColor
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
                        context.read<DashboardBloc>().add(ReloadData());
                        setState(() {
                          _state = 0;
                          _noteController.clear();
                        });
                        _noteController.text = "sent!";
                      } else {
                        showAlertDialog(
                            context, "Cannot send note!\nTry again later!");
                      }
                    },
                    child: Text("Send"),
                  ),
                ),
              ],
            ),
          ],
        ));
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
