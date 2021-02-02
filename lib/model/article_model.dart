import 'package:flutter/cupertino.dart';

import 'article_level.dart';

class ArticleModel {
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
  int learnProgress;
  bool isDownloading = false;
  // 原文
  String originText;
  String lrcPath;
  // 简要描述
  String desc;
  // 下载进度
  double downloadValue;
  String imageUrl = "assets/jupiter.png";
  bool isMark = false;
}
