import 'package:SuyuListening/ui/pages/login/login.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class RouterConfig {
  static void configureRoutes(FluroRouter router) {
    var loginPageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LoginPage();
    });

    router.define("/login", handler: loginPageHandler);
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Container(
        child: Text("正在开发中...."),
      );
    });
  }
}
