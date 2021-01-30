import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// -------------------------------
/// Created with Flutter Dart File.
/// User tianNanYiHao@163.com
/// Date: 2020-08-17
/// Time: 13:44
/// Des: 类似于 iOS的NSUserDefaults和Android的SharedPreferences 轻量级存储类
/// -------------------------------

class SharePreferencesUtils {
  /// 存/更 - 进行json序列化, 均为json字符串形式保存
  /// 成功返回 Future<bool> 的成功态
  /// 失败 抛出异常信息
  static Future<dynamic> _saveToLocalMap(String key, dynamic value) async {
    final com = Completer();
    final future = com.future;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs);
      String jsonEncodestr = jsonEncode(value);
      prefs.setString(key, jsonEncodestr);
      com.complete(true);
    } catch (err) {
      com.complete(false);
      print(' save  is  err ,,,,,');
      print(err.toString());
    }
    return future;
  }

  /// 删 - 根据key 删除对应的数据
  /// 成功返回 Future<bool> 的成功态
  /// 失败 抛出异常信息
  static Future<dynamic> _deleteFromLocalMap(String key) async {
    final com = Completer();
    final future = com.future;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
      com.complete(true);
    } catch (err) {
      com.complete(false);
      print(err.toString());
    }
    return future;
  }

  /// 取 - 读取key 对应的json序列化字符串,并进行反序列化
  /// 成功返回 Future<dynamic> 的成功对象
  /// 失败 抛出异常信息
  static Future<dynamic> _readFromLocalMap(String key) async {
    final com = Completer();
    final future = com.future;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final values = prefs.get(key);
      var obj = jsonDecode(values);
      com.complete(obj);
      print('======= json反序列化后的dynamic对象 ======== :  ' + obj.toString());
      print(' read  is  ok ,,,,,');
    } catch (err) {
      // 读取失败, 仅返回一个null, 防止外部不catch,引起报错, 但是外部就需要做好判空
      com.complete(null);
      print(' read  is  err ,,,,,');
    }
    return future;
  }

  /// *********************************** SharePreferencesUtils 静态方法 ***********************************
  /// 存取删tokey
  /// [SharePreferencesUtilsWorkType] 指定操作模式
  static token(SharePreferencesUtilsWorkType type, {dynamic value}) {
    String key = 'token';
    if (type == SharePreferencesUtilsWorkType.save) {
      return _saveToLocalMap(key, value);
    }
    if (type == SharePreferencesUtilsWorkType.remove) {
      return _deleteFromLocalMap(key);
    }
    if (type == SharePreferencesUtilsWorkType.get) {
      return _readFromLocalMap(key);
    }
  }

  /// *********************************** 存取删sign ***********************************
  static sign(SharePreferencesUtilsWorkType type, {dynamic value}) {
    String key = 'sign';
    if (type == SharePreferencesUtilsWorkType.save) {
      return _saveToLocalMap(key, value);
    }
    if (type == SharePreferencesUtilsWorkType.remove) {
      return _deleteFromLocalMap(key);
    }
    if (type == SharePreferencesUtilsWorkType.get) {
      return _readFromLocalMap(key);
    }
  }

  /// 存取删user
  /// [SharePreferencesUtilsWorkType] 指定操作模式
  static user(SharePreferencesUtilsWorkType type, {dynamic value}) {
    String key = 'user';
    if (type == SharePreferencesUtilsWorkType.save) {
      return _saveToLocalMap(key, value);
    }
    if (type == SharePreferencesUtilsWorkType.remove) {
      return _deleteFromLocalMap(key);
    }
    if (type == SharePreferencesUtilsWorkType.get) {
      return _readFromLocalMap(key);
    }
  }

  /// 存取删时间戳timeStamp
  static timeStamp(SharePreferencesUtilsWorkType type, {dynamic value}) {
    String key = 'timeStamp';
    if (type == SharePreferencesUtilsWorkType.save) {
      return _saveToLocalMap(key, value);
    }
    if (type == SharePreferencesUtilsWorkType.remove) {
      return _deleteFromLocalMap(key);
    }
    if (type == SharePreferencesUtilsWorkType.get) {
      return _readFromLocalMap(key);
    }
  }
}

enum SharePreferencesUtilsWorkType {
  save,
  remove,
  get,
}
