import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/note.dart';

class NoteService {
  Future<Either<Failure, List<Note>>> getNotes() async {
    List<Note> _fakeNotes = List.generate(
      4,
      (index) => Note(
        id: index.toString(),
        patientEntry:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer dolor lacus, dapibus a vestibulum et, sollicitudin quis nunc.",
        psychologistEntry: "",
        name: "trikitirem",
        date: DateTime(2021, 3, 8),
        time: TimeOfDay(hour: 12, minute: 0),
      ),
    );
    return Right(_fakeNotes);
  }
}
