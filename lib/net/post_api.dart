import 'package:SuyuListening/entity/entities.dart';
import 'package:dio/dio.dart';

class PostApi {
  //单例
  factory PostApi() => _getInstance();

  static PostApi get instance => _getInstance();

  static PostApi _instance;

  PostApi._internal();

  static PostApi _getInstance() {
    if (_instance == null) {
      _instance = PostApi._internal();
    }
    return _instance;
  }

  Future<List<ArticleEntity>> getUpdateAPI(int timeStamp) async {
    Response response;
    Dio dio = new Dio(BaseOptions(
        baseUrl: "https://api-word.qdu.life/",
        contentType: Headers.jsonContentType));
    response = await dio.post("post/getUpdate/$timeStamp");
    if (response.statusCode == 200) {
      HttpResponseListEntity<ArticleEntity> result =
          HttpResponseListEntity<ArticleEntity>.fromJson(response.data);
      if (result.code == "0") {
        return result.data;
      } else {
        throw Exception("${result.msg}");
      }
    }
    return null;
  }
}
