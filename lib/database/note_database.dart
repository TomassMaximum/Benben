import 'dart:convert';
import 'dart:developer';

import 'package:benben/models/note_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {

  Database? database;

  init() async {
    database = await openDatabase(
        join(await getDatabasesPath(), 'notes_database.db'),
        onCreate: (db, version) {
          log("db onCreate");
          return db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY, created_at INTEGER, modified_at INTEGER, data TEXT)');
        },
      version: 1
    );
  }

  _initIfNot() async {
    if(database != null && database!.isOpen) {
      return;
    }
    await init();
  }

  insertNote(NoteData noteData) async {
    await _initIfNot();

    log("insert: ${jsonEncode(noteData)}");

    database!.insert('notes', {
      'created_at': noteData.createdAt,
      'modified_at': noteData.modifiedAt,
      'data': jsonEncode(noteData)
      }
    );

  }

  Future<List<NoteData>> queryNotes() async {

    await _initIfNot();

    List<Map<String, dynamic>> maps = await database!.query('notes');

    if(maps.isNotEmpty) {
      log("query: ${maps[0]['data']}");
    }

    return List.generate(maps.length, (i) {
      return NoteData.fromJson(jsonDecode(maps[i]['data']), maps[i]['id']);
    }).reversed.toList();
  }

  deleteNote(int id) async {
    await _initIfNot();

    await database!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}