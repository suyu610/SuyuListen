import 'package:SuyuListening/db/db_manager.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDBProvider {
  bool isTableExists = false;
  tableSqlString();
  tableName();
  tableBaseString(String name, String columnId) {
    return '''
    create table $name(
      $columnId integer primary key,    
    ''';
  }

  Future<Database> getDatabase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExists = await DBManager.isTableExists(name);
    if (!isTableExists) {
      Database db = await DBManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExists) {
      await prepare(tableName(), tableSqlString());
    }
    return await DBManager.getCurrentDatabase();
  }
}
