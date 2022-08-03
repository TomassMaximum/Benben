import 'dart:convert';
import 'dart:developer';

import 'package:benben/models/note_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {

  late Database database;

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

  insertNote(NoteData noteData) async {
    log("insert: ${jsonEncode(noteData)}");

    database.insert('notes', {
      'created_at': noteData.createdAt,
      'modified_at': noteData.modifiedAt,
      'data': jsonEncode(noteData)
      }
    );

  }

  Future<List<NoteData>> queryNotes() async {

    await init();

    List<Map<String, dynamic>> maps = await database.query('notes');

    if(maps.isNotEmpty) {
      log("query: ${maps[0]['data']}");
    }

    return List.generate(maps.length, (i) {
      return NoteData.fromJson(jsonDecode(maps[i]['data']));
    });
  }


  _openDatabase() async {
    database = await openDatabase(
        join(await getDatabasesPath(), 'notes_database.db'));
  }

  _closeDatabase() async {
    await database.close();
  }
}