import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';

import '../data_source/note_db_helper.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDbHelper db;

  NoteRepositoryImpl(this.db);

  @override
  Future<void> deleteNote(Note note) async {
    await db.deleteNote(note);
  }

  // await 빼는 이유
  // db.getNoteById(id) 타입이 Future 형이라서 불러오는 게 아니라 return 할 때는 쓸 필요 없음.
  // 위에 거 아니랜다. 결과를 받아서 return 하는 거라 await 쓰는 게 맞음.
  @override
  Future<Note?> getNoteById(int id) async {
    return await db.getNoteById(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return await db.getNotes();
  }

  @override
  Future<void> insertNote(Note note) async {
    await db.insertNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await db.updateNote(note);
  }
}
