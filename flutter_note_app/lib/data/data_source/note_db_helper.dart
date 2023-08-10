import 'package:sqflite/sqflite.dart';

import '../../domain/model/note.dart';

class NoteDbHelper {
  Database db;

  NoteDbHelper(this.db);

  Future<Note?> getNoteById(int id) async {
    // whereArgs의 param이 where에 순서대로 매핑됨.
    // SELECT * FROM note WHERE id = #{id}
    final List<Map<String, dynamic>> maps = await db.query(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Maps는 json 형식이라 보면 됨.
    // .fromJson() 으로 json to Note.
    // .map() 하지 않는 이유는 maps.first로 첫번째 값만 가져와서
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }

    return null;
  }

  Future<List<Note>> getNotes() async {
    final maps = await db.query('note');

    // .map() 로 루프 돌리고
    // .fromJson() 으로 json데이터를 Note로 변환
    // .toList() 로 Note를 List로 묶어서 리터
    return maps.map((map) => Note.fromJson(map)).toList();
  }

  Future<void> insertNote(Note note) async {
    // .toJson() 으로 Note를 주면 json으로 바꿔서 db에 insert
    await db.insert('note', note.toJson());
  }

  Future<void> updateNote(Note note) async {
    await db.update(
      'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(Note note) async {
    await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
