import 'package:flutter/cupertino.dart';
import 'article_level_enum.dart';

class ArticleEntity {
  String id = UniqueKey().toString();
  String title;
  // 音频的路径
  String audioPath;
  // 即音频文件hash值
  String fileName;
  // 属于什么话题
  int topicId;
  // 积分
  int coint;
  //
  TopicLevel level;
  int studyProgress;
  bool isDownloading = false;
  // 原文
  String originText;
  String lrcPath;
  // 简要描述
  String desc;
  // 下载进度
  double downloadValue;
  
  String imageUrl = "assets/jupiter.png";
  // 是否要保存
  bool isMark = false;

  ArticleEntity(
      {this.title = "title",
      this.coint = 30,
      this.level = TopicLevel.Easy,
      this.studyProgress = 10,
      this.downloadValue = 0,
      this.imageUrl = "assets/jupiter.png"});
}
