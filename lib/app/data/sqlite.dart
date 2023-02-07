// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqlite/app/data/note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await setDB();
    }
    return _db!;
  }

  Future setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = join(directory.path, "NoteDB");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT, desc TEXT)");
    print("Database note created");
  }

  Future<int> saveNote(Note note) async {
    var dbClient = await db;
    int res = await dbClient.insert("note", note.toJson());
    print("note inserted");
    return res;
  }

  Future<List<Note>> getNote() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM note");
    List<Note> noteData = [];
    for (int i = 0; i < list.length; i++) {
      var note = Note(list[i]['title'], list[i]['desc']);
      note.setNoteid(list[i]['id']);
      noteData.add(note);
    }
    return noteData;
  }

  Future<bool> updateNote(Note note) async {
    var dbClient = await db;
    int res = await dbClient.update("note", note.toJson(),
        where: "id=?", whereArgs: <int?>[note.id]);
    print("note updated");
    return res > 0 ? true : false;
  }

  Future<int> deleteNote(Note note) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete("DELETE FROM note WHERE id=?", [note.id]);
    print("note deleted");
    return res;
  }

  Future dropNote() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "NoteDB");
    databaseFactory.deleteDatabase(path);
    print("Database Drop");
  }
}
