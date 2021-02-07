import 'package:SuyuListening/config/pref_keys.dart';
import 'package:SuyuListening/controller/page_controller.dart';
import 'package:SuyuListening/net/user_api.dart';
import 'package:SuyuListening/utils/shared_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

GlobalKey innerDrawerKey;

class SplashController implements MyPageController {
  BuildContext context;
  SplashController(BuildContext context) {
    this.context = context;
    initController();
  }

  Future<String> decideWhereNeedGo() async {
    String routeStr = "/error";

    /// 首先判断是否存在[firstLauch]这一字段,如果不存在，则跳到onboarding页面
    bool isNotFirstLauch =
        await SharedUtil().getBoolean(PrefKeys.isNotFirstLauch);
    if (!isNotFirstLauch) {
      LogUtil.v("第一次启动", tag: this.runtimeType.toString());
      routeStr = "/onBoarding";
    } else {
      // 然后再检查是否登陆
      routeStr = await checkLogin();
    }

    return routeStr;
  }

  Future<String> checkLogin() async {
    String routeStr = "/error";
    // 首先判断是否存在token这一字段,如果不存在，则跳welcom
    String token = await SharedUtil().getString(PrefKeys.token);
    if (token == null) {
      routeStr = "/welcome";
    } else {
      // 如果存在，则发送给服务器，验证token的合法性
      // 发送请求，验证token合法性
      if (UserApi().tokenIsValid(token)) {
        // 如果合法，则跳转到主页面
        LogUtil.v("合法", tag: this.runtimeType.toString());
        routeStr = "/home";
        // 应该在此处，初始化一些用户信息。

      } else {
        // 如果不合法，则跳转登陆页面，并携带错误信息
        // 时间过长，请重新登录
        // 修改密码
        // 在其他地方上线
        LogUtil.v("不合法", tag: this.runtimeType.toString());

        routeStr = "/welcome?loginState='invalid'";
      }
    }
    return routeStr;
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
