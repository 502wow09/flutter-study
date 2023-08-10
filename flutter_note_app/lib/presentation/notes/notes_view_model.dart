import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

import '../../domain/model/note.dart';
import 'notes_event.dart';

class NotesViewModel with ChangeNotifier {
  final NoteRepository repository;

  NotesViewModel(this.repository);

  List<Note> _notes = [];
  Note? _recentlyDeletedNote;

  //전에 나왔던 .copy(), .add() 등 다 Exception으로 막은 클래스
  UnmodifiableListView<Note> get note => UnmodifiableListView(_notes);

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await repository.getNotes();
    _notes = notes;
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await repository.deleteNote(note);

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeletedNote != null) {
      repository.insertNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;

      _loadNotes();
    }
  }
}
