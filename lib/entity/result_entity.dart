import 'entity_factory.dart';

class HttpResponseListEntity<T> {
  String code;
  List<T> data;
  String msg;

  HttpResponseListEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<T>();
      (json['data'] as List).forEach((v) {
        data.add(EntityFactory.generateOBJ<T>(v));
      });
    }
    msg = json['msg'];
  }


  
}

class HttpResponseEntity<T> {
  T data;
  String msg;
  String code;

  HttpResponseEntity({this.data, this.msg, this.code});

  HttpResponseEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? EntityFactory.generateOBJ<T>(json['data'])
        : null;
    msg = json['msg'];
    code = json['code'];
  }
}
