// import 'package:SuyuListening/ui/pages/temp/message.dart';
// import 'package:SuyuListening/ui/pages/word_book/word_book_page.dart';
import 'package:SuyuListening/config/jpush_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'controller/wordbook_controller.dart';
import 'entity/search_model.dart';
import 'provider/key_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'ui/pages/splash/splash_page.dart';
import 'config/global.dart';
import 'constant/theme_color.dart';
import 'provider/listen_provider.dart';
import 'route/router_helper.dart';

void main() async {
  // 状态栏颜色
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);

  Global.init().then((value) => runApp(
        MultiProvider(providers: [
          ListenableProvider<WordBookController>(
              create: (_) => WordBookController()),
          ListenableProvider<SearchModel>(
            create: (_) => SearchModel(),
          ),
          ListenableProvider<ListenProvider>(
            create: (_) => ListenProvider(),
          ),
          ListenableProvider<KeyProvider>(
            create: (_) => KeyProvider(),
          ),
        ], child: MyApp()),
      ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JPush jpush = new JPush();

    jpush.setup(
      appKey: JPUSH_KEY,
      channel: "theChannel",
      production: false,
      debug: true, // 设置是否打印 debug 日志
    );

    jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: false,
      builder: () => ThemeProvider(
        initTheme: lightTheme,
        child: Builder(builder: (context) {
          return ColorFiltered(
            colorFilter: ColorFilter.mode(
                Provider.of<KeyProvider>(context, listen: true).isFocusMode
                    ? Colors.grey
                    : Colors.transparent,
                BlendMode.color),
            child: MaterialApp(
                onGenerateRoute: RouterHelper.router.generator,
                builder: EasyLoading.init(),
                debugShowCheckedModeBanner: false,
                title: '小兔崽听力',
                theme: ThemeProvider.of(context),
                home: SplashScreen()),
          );
        }),
      ),
    );
  }
}
