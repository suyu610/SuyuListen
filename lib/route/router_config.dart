import 'package:SuyuListening/ui/pages/listen/listen_page.dart';
import 'package:SuyuListening/ui/pages/on_boarding_page.dart';
import 'package:SuyuListening/ui/pages/records_detail/records_detail_page.dart';
import 'package:SuyuListening/ui/pages/route_error_page.dart';
import 'package:SuyuListening/ui/pages/test_page.dart';
import 'package:SuyuListening/ui/pages/word_book/word_book_page.dart';
import 'package:SuyuListening/ui/pages/word_detail/word_detail_page.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../ui/pages/article_detail/article_detail.dart';
import '../ui/pages/splash/splash_page.dart';
import '../ui/pages/avatar_setting/avatar_setting_page.dart';
import '../ui/pages/setting/setting_page.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/login/login_page.dart';
import '../ui/pages/welcom_page.dart';
import '../constant/theme_color.dart';

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
      // 跳转的时候，设置成白天模式
      return ThemeSwitcher(
        clipper: ThemeSwitcherCircleClipper(),
        builder: (context) {
          ThemeSwitcher.of(context).changeTheme(theme: lightTheme);
          return ArticleDetailPage();
        },
      );
    });
    var wordBookPageHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return WordBookPage();
      },
    );

    var recordsDetailPageHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return RecordsDetailPage();
      },
    );

    var listenPageHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return ListenPage();
      },
    );
    var onboardingPageHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return OnBoardingPage();
      },
    );
    var testPageHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return TestPage();
      },
    );

    var wordDetailPageHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      // 设置成白天模式
      return ThemeSwitcher(
        clipper: ThemeSwitcherCircleClipper(),
        builder: (context) {
          ThemeSwitcher.of(context).changeTheme(theme: lightTheme);
          return WordDetailPage();
        },
      );
    });

    router.define("/login", handler: loginPageHandler);
    router.define("/splash", handler: splashPageHandler);
    router.define("/welcome", handler: welcomePageHandler);
    router.define("/home", handler: homePageHandler);
    router.define("/avatar_setting", handler: avatarSettingPageHandler);
    router.define("/setting", handler: settingPageHandler);
    router.define("/article_detail", handler: articleDetailPageHandler);
    router.define("/word_detail", handler: wordDetailPageHandler);
    router.define("/word_book", handler: wordBookPageHandler);
    router.define("/records_detail", handler: recordsDetailPageHandler);
    router.define("/listen", handler: listenPageHandler);
    router.define("/onBoarding", handler: onboardingPageHandler);
    router.define("/test", handler: testPageHandler);

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return RouteErrorPage();
    });
  }
}
