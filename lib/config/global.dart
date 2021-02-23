import 'dart:io';
import 'dart:ui';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../constant/theme_color.dart';
import '../route/router_config.dart';
import '../route/router_helper.dart';
import '../utils/storage_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Global {
  static String userID;
  static GlobalKey<InnerDrawerState> innerDrawerKey =
      new GlobalKey<InnerDrawerState>();
  static GlobalKey<FloatingSearchBarState> floatingSearchBarKey =
      new GlobalKey<FloatingSearchBarState>();
  static GlobalKey<FloatingSearchAppBarState> wordbookSearchBarKey =
      new GlobalKey<FloatingSearchAppBarState>();

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    // 配置日志
    LogUtil.init(isDebug: true, maxLen: 20);
    // 创建必要的文件夹
    createFolders();
    // 初始化配置EasyLoading
    initToast();
    // 初始化路由
    initRoute();
    // 强制竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent);

      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

void initRoute() {
  final router = FluroRouter();
  RouterConfig.configureRoutes(router);
  RouterHelper.router = router;
}

void createFolders() {
  createFolder("audios");
  createFolder("lrc");
}

void initToast() {
  EasyLoading.instance
    ..textColor = Colors.black
    ..displayDuration = const Duration(milliseconds: 700)
    ..indicatorType = EasyLoadingIndicatorType.hourGlass
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 25.0
    ..radius = 10.0
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..backgroundColor = yellow
    ..indicatorColor = Colors.black
    ..textStyle = TextStyle(fontWeight: FontWeight.w500, color: Colors.black)
    ..fontSize = 13
    ..contentPadding = EdgeInsets.all(20)
    ..textPadding = EdgeInsets.only(bottom: 20)
    ..progressColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.4)
    ..userInteractions = true;
}
