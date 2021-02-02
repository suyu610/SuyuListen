import '../ui/pages/home_page.dart';
import '../ui/pages/login/login.dart';
import '../ui/pages/welcom_page.dart';
import '../ui/pages/splash/splash_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class RouterConfig {
  static void configureRoutes(FluroRouter router) {
    var loginPageHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LoginPage();
    });
    var splashPageHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return SplashScreen();
    });
    var welcomePageHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return WelcomePage();
    });
    var homePageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return HomePage();
    });
    // var loginPageHandler = Handler(
    //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    //   return LoginPage();
    // });
    // var loginPageHandler = Handler(
    //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    //   return LoginPage();
    // });
    // var loginPageHandler = Handler(
    //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    //   return LoginPage();
    // });
    router.define("/login", handler: loginPageHandler);
    router.define("/splash", handler: splashPageHandler);
    router.define("/welcome", handler: welcomePageHandler);
    router.define("/home", handler: homePageHandler);

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Container(
        child: Text("正在开发中...."),
      );
    });
  }
}
