class WordMeaning {
  List<dynamic> returnPhrase;
  String errorCode;
  String query;
  List<String> translation;
  Basic basic;
  List<Web> web;
  Dict dict;
  Dict webdict;
  String l;
  String tSpeakUrl;
  String speakUrl;

  WordMeaning(
      {this.returnPhrase,
      this.errorCode,
      this.query,
      this.translation,
      this.basic,
      this.web,
      this.dict,
      this.webdict,
      this.l,
      this.tSpeakUrl,
      this.speakUrl});

  WordMeaning.fromJson(Map<String, dynamic> json) {
    returnPhrase = json['returnPhrase'];
    errorCode = json['errorCode'];
    query = json['query'];
    translation = json['translation'].cast<String>();
    basic = json['basic'] != null ? new Basic.fromJson(json['basic']) : null;
    if (json['web'] != null) {
      web = new List<Web>();
      json['web'].forEach((v) {
        web.add(new Web.fromJson(v));
      });
    }
    dict = json['dict'] != null ? new Dict.fromJson(json['dict']) : null;
    webdict =
        json['webdict'] != null ? new Dict.fromJson(json['webdict']) : null;
    l = json['l'];
    tSpeakUrl = json['tSpeakUrl'];
    speakUrl = json['speakUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnPhrase'] = this.returnPhrase;
    data['errorCode'] = this.errorCode;
    data['query'] = this.query;
    data['translation'] = this.translation;
    if (this.basic != null) {
      data['basic'] = this.basic.toJson();
    }
    if (this.web != null) {
      data['web'] = this.web.map((v) => v.toJson()).toList();
    }
    if (this.dict != null) {
      data['dict'] = this.dict.toJson();
    }
    if (this.webdict != null) {
      data['webdict'] = this.webdict.toJson();
    }
    data['l'] = this.l;
    data['tSpeakUrl'] = this.tSpeakUrl;
    data['speakUrl'] = this.speakUrl;
    return data;
  }
}

class Basic {
  String phonetic;
  String ukPhonetic;
  String usPhonetic;
  String ukSpeech;
  String usSpeech;
  List<String> explains;

  Basic(
      {this.phonetic,
      this.ukPhonetic,
      this.usPhonetic,
      this.ukSpeech,
      this.usSpeech,
      this.explains});

  Basic.fromJson(Map<String, dynamic> json) {
    phonetic = json['phonetic'];
    ukPhonetic = json['uk-phonetic'];
    usPhonetic = json['us-phonetic'];
    ukSpeech = json['uk-speech'];
    usSpeech = json['us-speech'];
    explains = json['explains'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonetic'] = this.phonetic;
    data['uk-phonetic'] = this.ukPhonetic;
    data['us-phonetic'] = this.usPhonetic;
    data['uk-speech'] = this.ukSpeech;
    data['us-speech'] = this.usSpeech;
    data['explains'] = this.explains;
    return data;
  }
}

class Web {
  String key;
  List<String> value;

  Web({this.key, this.value});

  Web.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Dict {
  String url;

  Dict({this.url});

  Dict.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
