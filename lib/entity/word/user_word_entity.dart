import 'dart:convert';

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

  UserWordEntity copyWith({
    String word,
    String definition,
    double progress,
    bool tempIsCompelete,
    String audioUrl,
    bool isCache,
  }) {
    return UserWordEntity(
      word: word ?? this.word,
      definition: definition ?? this.definition,
      progress: progress ?? this.progress,
      tempIsCompelete: tempIsCompelete ?? this.tempIsCompelete,
      audioUrl: audioUrl ?? this.audioUrl,
      isCache: isCache ?? this.isCache,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'definition': definition,
      'progress': progress,
      'tempIsCompelete': tempIsCompelete,
      'audioUrl': audioUrl,
      'isCache': isCache,
    };
  }

  factory UserWordEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserWordEntity(
      word: map['word'],
      definition: map['definition'],
      progress: map['progress'],
      tempIsCompelete: map['tempIsCompelete'],
      audioUrl: map['audioUrl'],
      isCache: map['isCache'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserWordEntity.fromJson(String source) => UserWordEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserWordEntity(word: $word, definition: $definition, progress: $progress, tempIsCompelete: $tempIsCompelete, audioUrl: $audioUrl, isCache: $isCache)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserWordEntity &&
      o.word == word &&
      o.definition == definition &&
      o.progress == progress &&
      o.tempIsCompelete == tempIsCompelete &&
      o.audioUrl == audioUrl &&
      o.isCache == isCache;
  }

  @override
  int get hashCode {
    return word.hashCode ^
      definition.hashCode ^
      progress.hashCode ^
      tempIsCompelete.hashCode ^
      audioUrl.hashCode ^
      isCache.hashCode;
  }
}
