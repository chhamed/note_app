import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'note_model.dart';

class NoteNotifier extends ChangeNotifier {
  late List<Note> notes;
  late List<Note> notestoshow;
  void init() {
    notes = [];
    notestoshow = [];
  }

  void addnote(Note note) {
    note.id = notes.length;
    notes.add(note);
    notestoshow.add(note);
    notifyListeners();
  }

  void editnote(Note note) {
    final int index = notes.indexWhere((element) => element.id==note.id);

  notes [index] = note;
  print(index);
    final int index2 = notestoshow.indexWhere((element) => element.id==note.id);
    print(index2);
    notestoshow[index2] = note;
    notifyListeners();
  }

  void search(String query) {

    List<Note> searcheditems = [];
    for (Note i in notes) {

      if (i.title.toLowerCase().contains(query.toString().toLowerCase())) {
        searcheditems.add(i);


      }
    }

    this.notestoshow = searcheditems;
    notifyListeners();
  }
}
