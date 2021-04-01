import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../../../core/const.dart';
import '../widgets/note_grid.dart';

// ignore: must_be_immutable
class DashboardHomePage extends StatelessWidget {
  DashboardHomePage({@required ObjectId id}) : _id = id;
  final ObjectId _id;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: kRightBorder,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ///
                /// Section title
                ///
                Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: kBottomBorder,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Recent Appointments",
                          style: kSubtitle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),

                ///
                /// List of appointments
                ///
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: NoteGird(
            //TODO: add notes from bloc
            notes: [],
          ),
        ),
      ],
    );
  }
}
