class UserWordEntity {
  // 单词本身
  String word;
  // 解释
  String definition;
  // 掌握情况
  double progress;
  // 用于在单词本中，临时完成
  bool tempIsCompelete;
  // 发音url
  String audioUrl;
  // 是否已经缓存
  bool isCache;

  UserWordEntity({
    this.word,
    this.definition,
    this.progress,
    this.tempIsCompelete = false,
    this.audioUrl,
    this.isCache,
  });
}
