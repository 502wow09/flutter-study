import '../model/note.dart';

abstract class NoteRepository {
  //비동기로 DB에서 가져올 것을 생각해서 Future
  Future<List<Note>> getNotes();

  Future<Note?> getNoteById(int id);

  Future<void> insertNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> deleteNote(Note note);
}
