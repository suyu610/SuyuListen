import 'package:common_utils/common_utils.dart';

class UserApi {
  //单例
  factory UserApi() => _getInstance();

  static UserApi get instance => _getInstance();
  static UserApi _instance;

  UserApi._internal() {
    //初始化
  }

  static UserApi _getInstance() {
    if (_instance == null) {
      _instance = new UserApi._internal();
    }
    return _instance;
  }

  bool tokenIsValid(String token) {

    return true;
  }
}
