import 'article_entity.dart';

class UserArticleEntity {
  // 下载进度
  double downloadValue;
  //
  bool isDownloading = false;

  // 最高100
  int studyProgress;
  // 是否要保存
  bool isMark = false;

  ArticleEntity articleEntity;

  UserArticleEntity(
      {this.downloadValue = 10,
      this.isDownloading = false,
      this.studyProgress = 10,
      this.articleEntity,});
}
