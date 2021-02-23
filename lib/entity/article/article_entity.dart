import 'dart:convert';
import 'package:common_utils/common_utils.dart';

import '../lrc_entity.dart';

enum TopicLevel { VeryEasy, Easy, Normal, Hard, VeryNormal }

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
  LrcEntity lrcEntity;
  ArticleEntity(
    this.id,
    this.audioUrl,
    this.coins,
    this.desc,
    this.fileName,
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
    this.localLrcPath,
    this.lrcEntity,
  );

  ArticleEntity copyWith({
    int id,
    String audioUrl,
    int coins,
    String desc,
    String fileName,
    String imageUrl,
    TopicLevel level,
    String lrcUrl,
    String originText,
    String title,
    String topic,
    String transText,
    DateTime updateTime,
    String wordlist,
    String localAudioPath,
    String localLrcPath,
    LrcEntity lrcEntity,
  }) {
    return ArticleEntity(
      id ?? this.id,
      audioUrl ?? this.audioUrl,
      coins ?? this.coins,
      desc ?? this.desc,
      fileName ?? this.fileName,
      imageUrl ?? this.imageUrl,
      level ?? this.level,
      lrcUrl ?? this.lrcUrl,
      originText ?? this.originText,
      title ?? this.title,
      topic ?? this.topic,
      transText ?? this.transText,
      updateTime ?? this.updateTime,
      wordlist ?? this.wordlist,
      localAudioPath ?? this.localAudioPath,
      localLrcPath ?? this.localLrcPath,
      lrcEntity ?? this.lrcEntity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'audioUrl': audioUrl,
      'coins': coins,
      'desc': desc,
      'fileName': fileName,
      'imageUrl': imageUrl,
      'level': level,
      'lrcUrl': lrcUrl,
      'originText': originText,
      'title': title,
      'topic': topic,
      'transText': transText,
      'updateTime': updateTime?.millisecondsSinceEpoch,
      'wordlist': wordlist,
      'localAudioPath': localAudioPath,
      'localLrcPath': localLrcPath,
      'lrcEntity': lrcEntity?.toMap(),
    };
  }

  factory ArticleEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ArticleEntity(
      map['id'],
      map['audioUrl'],
      map['coins'],
      map['desc'],
      map['fileName'],
      map['imageUrl'],
      TopicLevel.Easy,
      map['lrcUrl'],
      map['originText'],
      map['title'],
      map['topic'],
      map['transText'],
      DateUtil.getDateTime((map['updateTime'])) ??
          DateUtil.getDateTime(DateUtil.getNowDateStr()),
      map['wordlist'],
      map['localAudioPath'],
      map['localLrcPath'],
      LrcEntity.fromMap(map['lrcEntity']) ?? LrcEntity(savePath: map["fileName"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleEntity.fromJson(String source) =>
      ArticleEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ArticleEntity(id: $id, audioUrl: $audioUrl, coins: $coins, desc: $desc, fileName: $fileName, imageUrl: $imageUrl, level: ${level.toString()}, lrcUrl: $lrcUrl, originText: $originText, title: $title, topic: $topic, transText: $transText, updateTime: $updateTime, wordlist: $wordlist, localAudioPath: $localAudioPath, localLrcPath: $localLrcPath, lrcEntity: $lrcEntity)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ArticleEntity &&
        o.id == id &&
        o.audioUrl == audioUrl &&
        o.coins == coins &&
        o.desc == desc &&
        o.fileName == fileName &&
        o.imageUrl == imageUrl &&
        o.level == level &&
        o.lrcUrl == lrcUrl &&
        o.originText == originText &&
        o.title == title &&
        o.topic == topic &&
        o.transText == transText &&
        o.updateTime == updateTime &&
        o.wordlist == wordlist &&
        o.localAudioPath == localAudioPath &&
        o.localLrcPath == localLrcPath &&
        o.lrcEntity == lrcEntity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        audioUrl.hashCode ^
        coins.hashCode ^
        desc.hashCode ^
        fileName.hashCode ^
        imageUrl.hashCode ^
        level.hashCode ^
        lrcUrl.hashCode ^
        originText.hashCode ^
        title.hashCode ^
        topic.hashCode ^
        transText.hashCode ^
        updateTime.hashCode ^
        wordlist.hashCode ^
        localAudioPath.hashCode ^
        localLrcPath.hashCode ^
        lrcEntity.hashCode;
  }
}
