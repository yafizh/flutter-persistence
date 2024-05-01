import 'package:path/path.dart';
import 'package:persistence/models/Note.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class Database {
  late sqflite.Database database;
  final tableName = 'notes';

  Future<void> initDatabase() async {
    database = await sqflite.openDatabase(
        join(await sqflite.getDatabasesPath(), 'note_database.db'),
        onCreate: (db, version) {
      return db.execute("""
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT, 
            desc TITLE
          )""");
    }, version: 1);
  }

  Future<void> insertNote(Note note) async {
    await initDatabase();
    await database.insert('notes', note.toMap());
  }

  Future<void> updateNote(int id, Note note) async {
    await initDatabase();
    database.update('notes', note.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteNote(int id) async {
    await initDatabase();
    database.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Note>> notes() async {
    await initDatabase();
    List<Map<String, Object?>> notes = await database.query('notes');
    return [
      for (final {'id': id, 'title': title, 'desc': desc} in notes)
        Note(id: (id as int), title: title.toString(), desc: desc.toString())
    ];
  }
}
