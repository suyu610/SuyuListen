import 'package:SuyuListening/controller/page_controller.dart';
import 'package:flutter/material.dart';

GlobalKey innerDrawerKey;

class SplashController implements MyPageController {
  BuildContext context;

  SplashController(BuildContext context) {
    this.context = context;
    initController();
  }

  Future<bool> checkLogin() async {
    bool flag = false;
    // 首先判断是否存在token这一字段
    // 如果存在，则发送给服务器，验证token的合法性
    // 如果通过，则返回true
    // 如果不通过，则返回false
    await Future.delayed(Duration(milliseconds: 1800), () {
      flag = true;
    });

    return flag;
  }

  @override
  Future disposeController() {
    return null;
  }

  // 实现一些初始化时，需要做的事
  @override
  Future initController() {
    // 检查本地是否有token
    return null;
  }
}
