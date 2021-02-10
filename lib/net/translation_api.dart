// dart库
import '../entity/entities.dart';
import 'package:SuyuListening/config/youdao_trans_api_config.dart';
import 'package:common_utils/common_utils.dart';

import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';

String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}

String generatSha256(String data) {
  var content = new Utf8Encoder().convert(data);
  var sha256 = crypto.sha256;
  var digest = sha256.convert(content);
  return hex.encode(digest.bytes);
}

String generatYoudaoInput(String word) {
  String output = "";
  if (word.length <= 20) {
    output = word;
  } else {
    output = word.substring(0, 10) +
        word.length.toString() +
        word.substring(word.length - 10, word.length);
  }
  print("=====");
  print(output);
  print("=====");
  return output;
}

/// !! you should replace the APP_KEY and SECRET with your own

Future<YouDaoWordEntity> getYouDaoTranslation(String word) async {
  // appid+word+salt+密钥

  var salt = ((DateTime.now().millisecondsSinceEpoch)).toString();

  var input = generatYoudaoInput(word);

  String curtime = ((DateTime.now().millisecondsSinceEpoch) ~/ 1000).toString();

  // ID+input+salt+curtime+应用密钥
  String str1 = APP_KEY + input + salt + curtime + SECRET;

  String mySha256Str = generatSha256(str1);

  Response response;
  Dio dio = new Dio(BaseOptions(
      baseUrl: "https://openapi.youdao.com/",
      contentType: Headers.jsonContentType));

  Map<String, dynamic> t = {
    'q': word,
    'from': "en",
    'to': "zh-CHS",
    'appKey': APP_KEY,
    'salt': salt,
    'sign': mySha256Str,
    'signType': "v3",
    'curtime': curtime,
  };

  FormData formData = FormData.fromMap(t);
  response = await dio.post("/api", data: formData);

  LogUtil.v(response.data.toString());
  return YouDaoWordEntity.fromJson(response.data);
}

// 通过前缀查找
Future<List<SimpleWordEntity>> getSimpleWordListByPrefix(
    String prefix, int limit) async {
  Response response;
  Dio dio = new Dio(BaseOptions(
      baseUrl: "https://api-word.qdu.life/",
      contentType: Headers.jsonContentType));
  response = await dio.post("/dict/getMeaning/prefix/$prefix/$limit");
  if (response.statusCode == 200) {
    // print(response.data);
    HttpResponseListEntity<SimpleWordEntity> result =
        HttpResponseListEntity<SimpleWordEntity>.fromJson(response.data);

    if (result.code == "0" && result.data.isNotEmpty) {
      return result.data;
    }
  }
  return null;
}

// 查找一群单词

// 通过单词查找
Future<SimpleWordEntity> getSimpleWordByWord(List<String> word) async {
  Response response;
  Dio dio = new Dio(BaseOptions(
      baseUrl: "https://api-word.qdu.life/",
      contentType: Headers.jsonContentType));
  response = await dio.post("/dict/getMeaning/$word");
  if (response.statusCode == 200) {
    // print(response.data);
    HttpResponseEntity<SimpleWordEntity> result =
        HttpResponseEntity<SimpleWordEntity>.fromJson(response.data);

    if (result.code == "0" && result.data != null) {
      return result.data;
    }
  }
  return null;
}

// 通过单词查找
Future<List<SimpleWordEntity>> getSimpleWordList(List<String> words) async {
  Response response;
  String wordParameter = "";
  words.forEach((element) {
    wordParameter += element;
  });

  print(wordParameter);
  Dio dio = new Dio(BaseOptions(
      baseUrl: "https://api-word.qdu.life/",
      contentType: Headers.jsonContentType));
  response = await dio.post("/dict/getMeaning/i/simple?words=$wordParameter");
  if (response.statusCode == 200) {
    // print(response.data);
    HttpResponseListEntity<SimpleWordEntity> result =
        HttpResponseListEntity<SimpleWordEntity>.fromJson(response.data);

    if (result.code == "0") {
      return result.data;
    } else {
      throw Exception("${result.msg}");
    }
  }
  return null;
}

// http://192.168.3.11:2222/dict/getMeaning/prefix/aban/20
