import 'dart:convert';

class SimpleWordEntity {
  String audio;
  String bnc;
  String collins;
  String definition;
  String detail;
  String exchange;
  String frq;
  String oxford;
  String phonetic;
  String pos;
  String tag;
  String translation;
  String word;
  SimpleWordEntity({
    this.audio,
    this.bnc,
    this.collins,
    this.definition,
    this.detail,
    this.exchange,
    this.frq,
    this.oxford,
    this.phonetic,
    this.pos,
    this.tag,
    this.translation,
    this.word,
  });



  SimpleWordEntity copyWith({
    String audio,
    String bnc,
    String collins,
    String definition,
    String detail,
    String exchange,
    String frq,
    String oxford,
    String phonetic,
    String pos,
    String tag,
    String translation,
    String word,
  }) {
    return SimpleWordEntity(
      audio: audio ?? this.audio,
      bnc: bnc ?? this.bnc,
      collins: collins ?? this.collins,
      definition: definition ?? this.definition,
      detail: detail ?? this.detail,
      exchange: exchange ?? this.exchange,
      frq: frq ?? this.frq,
      oxford: oxford ?? this.oxford,
      phonetic: phonetic ?? this.phonetic,
      pos: pos ?? this.pos,
      tag: tag ?? this.tag,
      translation: translation ?? this.translation,
      word: word ?? this.word,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'audio': audio,
      'bnc': bnc,
      'collins': collins,
      'definition': definition,
      'detail': detail,
      'exchange': exchange,
      'frq': frq,
      'oxford': oxford,
      'phonetic': phonetic,
      'pos': pos,
      'tag': tag,
      'translation': translation,
      'word': word,
    };
  }

  factory SimpleWordEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SimpleWordEntity(
      audio: map['audio'],
      bnc: map['bnc'],
      collins: map['collins'],
      definition: map['definition'],
      detail: map['detail'],
      exchange: map['exchange'],
      frq: map['frq'],
      oxford: map['oxford'],
      phonetic: map['phonetic'],
      pos: map['pos'],
      tag: map['tag'],
      translation: map['translation'],
      word: map['word'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleWordEntity.fromJson(String source) => SimpleWordEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SimpleWordEntity(audio: $audio, bnc: $bnc, collins: $collins, definition: $definition, detail: $detail, exchange: $exchange, frq: $frq, oxford: $oxford, phonetic: $phonetic, pos: $pos, tag: $tag, translation: $translation, word: $word)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is SimpleWordEntity &&
      o.audio == audio &&
      o.bnc == bnc &&
      o.collins == collins &&
      o.definition == definition &&
      o.detail == detail &&
      o.exchange == exchange &&
      o.frq == frq &&
      o.oxford == oxford &&
      o.phonetic == phonetic &&
      o.pos == pos &&
      o.tag == tag &&
      o.translation == translation &&
      o.word == word;
  }

  @override
  int get hashCode {
    return audio.hashCode ^
      bnc.hashCode ^
      collins.hashCode ^
      definition.hashCode ^
      detail.hashCode ^
      exchange.hashCode ^
      frq.hashCode ^
      oxford.hashCode ^
      phonetic.hashCode ^
      pos.hashCode ^
      tag.hashCode ^
      translation.hashCode ^
      word.hashCode;
  }
}
