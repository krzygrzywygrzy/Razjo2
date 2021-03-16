import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../../../core/const.dart';
import '../../../../core/erros/failures.dart';
import '../../../../models/note.dart';
import '../bloc/dashboard_bloc.dart';
import '../../../../services/note_service.dart';
import '../../../../widgets/note_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteGird extends StatelessWidget {
  const NoteGird({
    Key key,
    @required NoteService noteService,
    @required ObjectId objectId,
  })  : _noteService = noteService,
        _objectId = objectId,
        super(key: key);

  final NoteService _noteService;
  final ObjectId _objectId;

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
          FutureBuilder(
            future: _noteService.getNotes(_objectId),
            builder: (BuildContext context,
                AsyncSnapshot<Either<Failure, List<Note>>> snapshot) {
              if (snapshot.hasData && snapshot.data.isRight()) {
                List<Note> _notes = snapshot.data.getOrElse(() => <Note>[]);
                return Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: _state is DashboardHome ? 3 : 2,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      return NoteCard(
                        note: _notes[index],
                      );
                    },
                  ),
                ));
              } else
                return Center(
                  child: Text("loading..."),
                );
            },
          ),
        ],
      ),
    );
  }
}
