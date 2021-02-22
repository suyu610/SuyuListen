import 'package:common_utils/common_utils.dart';

import 'article_level_enum.dart';

class ArticleEntity {
  int id;
  String audioUrl;
  int coins;
  String desc;
  String fileName;
  String imageUrl;
  TopicLevel level;
  String lrcUrl;
  String originText;
  String title;
  String topic;
  String transText;
  DateTime updateTime;
  String wordlist;
  String localAudioPath;
  String localLrcPath;
  ArticleEntity(
      {this.audioUrl,
      this.coins,
      this.desc,
      this.fileName,
      this.id,
      this.imageUrl,
      this.level,
      this.lrcUrl,
      this.originText,
      this.title,
      this.topic,
      this.transText,
      this.updateTime,
      this.wordlist,
      this.localAudioPath,
      this.localLrcPath});

  ArticleEntity.fromJson(Map<String, dynamic> json) {
    audioUrl = json['audioUrl'];
    coins = json['coins'];
    desc = json['desc'];
    fileName = json['fileName'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    level =
        TopicLevel.values[json['level']]; //TopicLevel.values(json['level']);
    lrcUrl = json['lrcUrl'];
    originText = json['originText'];
    title = json['title'];
    topic = json['topic'];
    transText = json['transText'];
    updateTime = DateUtil.getDateTime((json['updateTime'])) ??
        DateUtil.getDateTime(DateUtil.getNowDateStr());

    wordlist = json['wordlist'];
    localAudioPath = json['localAudioPath'];
    localLrcPath = json['localLrcPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audioUrl'] = this.audioUrl ?? "null";
    data['coins'] = this.coins ?? "null";
    data['desc'] = this.desc ?? "null";
    data['fileName'] = this.fileName ?? "null";
    data['id'] = this.id ?? "null";
    data['imageUrl'] = this.imageUrl ?? "null";
    data['level'] = this.level.index ?? "null";
    data['lrcUrl'] = this.lrcUrl ?? "null";
    data['originText'] = this.originText ?? "null";
    data['title'] = this.title ?? "null";
    data['topic'] = this.topic ?? "null";
    data['transText'] = this.transText ?? "null";
    data['updateTime'] = this.updateTime ?? "null";
    data['wordlist'] = this.wordlist ?? "null";
    data['localAudioPath'] = this.localAudioPath ?? "null";
    data['localLrcPath'] = this.localLrcPath ?? "null";

    return data;
  }
}
