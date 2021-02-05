import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'suyuDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'my_word';

  // 主键:单词本身
  static final columnWord = '_word';
  // 熟练度
  static final columnProgress = 'progress';

  // making it a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // ignore: missing_return
  Future _onCreate(Database db, int version) {
    db.query('''
      CREATE TABLE $_tableName(
        $columnWord TEXT PRIMARY KEY,
        $columnProgress NUMERIC DEFAULT 0,
        ) 
      ''');
  }
}
