// dart库
import 'dart:async';
import 'dart:developer';
import 'package:SuyuListening/config/youdao_trans_api_config.dart';
import 'package:SuyuListening/model/word_model/word_meaning.dart';
import 'package:common_utils/common_utils.dart';
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

Future<WordMeaning> getTranslation(String word) async {
  WordMeaning temp = WordMeaning();
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
    'appKey': appkey,
    'salt': salt,
    'sign': mySha256Str,
    'signType': "v3",
    'curtime': curtime,
  };

  FormData formData = FormData.fromMap(t);
  response = await dio.post("/api", data: formData);

  LogUtil.v(response.data.toString());
  return WordMeaning.fromJson(response.data);
}
