import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/ui/pages/article_page/article_detail.dart';
import 'package:SuyuListening/ui/pages/avatar_setting_page/avatar_setting_page.dart';
import 'package:SuyuListening/ui/pages/setting_page/setting_page.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../ui/pages/home_page.dart';
import '../ui/pages/login_page/login.dart';
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
    var avatarSettingPageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return AvatarSettingPage();
    });

    var settingPageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return SettingPage();
    });

    var articleDetailPageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      ThemeSwitcher.of(context).changeTheme(theme: lightTheme);
      return ArticleDetailPage();
    });

    // var loginPageHandler = Handler(
    //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    //   return LoginPage();
    // });
    router.define("/login", handler: loginPageHandler);
    router.define("/splash", handler: splashPageHandler);
    router.define("/welcome", handler: welcomePageHandler);
    router.define("/home", handler: homePageHandler);
    router.define("/avatar_setting", handler: avatarSettingPageHandler);
    router.define("/setting", handler: settingPageHandler);
    router.define("/articleDetail", handler: articleDetailPageHandler);

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Container(
        child: Text("正在开发中...."),
      );
    });
  }
}
