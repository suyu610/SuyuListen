import 'package:SuyuListening/db/db_provider.dart';
import 'package:SuyuListening/entity/entities.dart';
import 'package:sqflite/sqlite_api.dart';

class ArticleDAO extends BaseDBProvider {
  /// 表名
  final String name = "Article";

  /// 主键
  final String columnId = "_id";

  @override
  tableName() {
    return name;
  }

  ///
  /// 创建表的sql
  ///
  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
    id integer not null,
    title text not null,
    fileName text not null,
    topic text not null,
    audioUrl text not null,
    lrcUrl text not null,
    updateTime datetime,
    originText text,
    transText text, 
    coins INTEGER, 
    level INTEGER,
    imageUrl text,
    desc text,
    wordlist text,
    localAudioPath text,
    localLrcPath text)
    ''';
  }

  ///
  /// 插入一条数据
  ///
  Future insert(ArticleEntity articleEntity) async {
    Database db = await getDatabase();
    // 判断如果没有该title,则插入，否则不插入
    bool isExist = await isExistByTitle(articleEntity.title);
    if (!isExist) {
      return await db.insert(name, articleEntity.toJson());
    }
  }

  ///
  /// 根据id获得一篇文章
  ///

  Future<ArticleEntity> getArticleById(int id) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> maps =
        await db.query(name, where: "id=?", whereArgs: [id]);
    if (maps.length > 0) {
      ArticleEntity articleEntity = ArticleEntity.fromJson(maps.first);
      return articleEntity;
    }
    return null;
  }

  ///
  /// 判断该title是否存在
  ///

  Future<bool> isExistByTitle(String title) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> maps =
        await db.query(name, where: "title=?", whereArgs: [title]);
    if (maps.length > 0) {
      return true;
    }
    return false;
  }

  ///
  ///  获取文章列表
  ///

  Future<List<ArticleEntity>> getArticleList() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await db.query(name);
    if (maps.length > 0) {
      List<ArticleEntity> list =
          maps.map((e) => ArticleEntity.fromJson(e)).toList();
      return list;
    }
    return null;
  }

  ///
  /// 清空文章表
  ///
  Future<int> deleteAllArticle() async {
    Database db = await getDatabase();
    String sql = 'DELETE FROM $name';
    return await db.rawDelete(sql);
  }
}
