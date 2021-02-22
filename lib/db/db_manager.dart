import 'dart:io';

import 'package:sqflite/sqflite.dart';

class DBManager {
  // 数据库版本
  static const int _VERSION = 1;
  // 数据库名称
  static const String _DB_NAME = "suyu_listen.db";

  /// 数据库实例
  static Database _database;

  static init() async {
    var databasePath = await getDatabasesPath();
    String dbName = _DB_NAME;
    String path = databasePath + dbName;

    if (Platform.isIOS) {
      path = databasePath + "/" + dbName;
    }

    // 打开数据库

    _database = await openDatabase(path, version: _VERSION,
        onCreate: (Database db, int version) async {
      //  在此处创建表
    });
  }

  ///
  /// 判断指定表是否存在
  ///
  static isTableExists(String tableName) async {
    await getCurrentDatabase();


    String sql =
        "select * from Sqlite_master where type= 'table' and name = '$tableName'";
    var res = await _database.rawQuery(sql);
    return res != null && res.length > 0;
  }

  ///
  /// 获取当前的数据库实例
  ///

  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  ///
  /// 关闭数据库
  ///

  static close() {
    _database?.close();
    _database = null;
  }
}
