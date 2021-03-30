import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../core/const.dart';
import '../../../../models/note.dart';
import '../bloc/dashboard_bloc.dart';
import '../../../../widgets/note_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteGird extends StatelessWidget {
  const NoteGird({
    Key key,
    @required List<Note> notes,
    Function display,
  })  : _notes = notes,
        _display = display,
        super(key: key);

  final List<Note> _notes;
  final Function _display;

  @override
  Widget build(BuildContext context) {
    DashboardState _state = context.read<DashboardBloc>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ///
          /// Title section + search bar
          ///
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notes",
                  style: kSubtitle,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.search,
                    size: 18,
                  ),
                ),
              ],
            ),
            height: 40,
            decoration: BoxDecoration(
              border: kBottomBorder,
            ),
          ),

          ///
          ///  Notes section
          ///
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: _notes.length > 0
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        crossAxisCount: _state is DashboardHome ? 3 : 2,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        return NoteCard(
                          note: _notes[index],
                          onTap: () => _display(index),
                        );
                      },
                    )
                  : Center(
                      child: Text("No notes to display!"),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
