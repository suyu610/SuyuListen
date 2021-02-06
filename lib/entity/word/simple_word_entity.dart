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

  SimpleWordEntity(
      {this.audio,
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
      this.word});

  SimpleWordEntity.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
    bnc = json['bnc'];
    collins = json['collins'];
    definition = json['definition'];
    detail = json['detail'];
    exchange = json['exchange'];
    frq = json['frq'];
    oxford = json['oxford'];
    phonetic = json['phonetic'];
    pos = json['pos'];
    tag = json['tag'];
    translation = json['translation'];
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    data['bnc'] = this.bnc;
    data['collins'] = this.collins;
    data['definition'] = this.definition;
    data['detail'] = this.detail;
    data['exchange'] = this.exchange;
    data['frq'] = this.frq;
    data['oxford'] = this.oxford;
    data['phonetic'] = this.phonetic;
    data['pos'] = this.pos;
    data['tag'] = this.tag;
    data['translation'] = this.translation;
    data['word'] = this.word;
    return data;
  }
}