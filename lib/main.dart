import 'package:SuyuListening/ui/pages/listen/listen_page.dart';
// import 'package:SuyuListening/ui/pages/splash/splash_screen.dart';

import 'provider/key_provider.dart';

// import '.../../ui/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'config/global.dart';
import 'constant/theme_color.dart';
import 'provider/listen_provider.dart';
import 'route/router_helper.dart';

void main() async {
  // 状态栏颜色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      // optional: set false to disable printing logs to console
      debug: true);

  Global.init().then((value) => runApp(
        MultiProvider(providers: [
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
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: true,
      child: ThemeProvider(
        initTheme: lightTheme,
        child: Builder(builder: (context) {
          return MaterialApp(
              onGenerateRoute: RouterHelper.router.generator,
              builder: EasyLoading.init(),
              debugShowCheckedModeBanner: false,
              title: '小兔崽听力',
              theme: ThemeProvider.of(context),
              home: ListenPage());
        }),
      ),
    );
  }
}

// Future _validateLogin() async {
//   Future<dynamic> future = Future(() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString("loginToken");
//   });
//   future.then((val) {
//     if (val == null) {
//       setState(() {
//         loginState = 0;
//       });
//     } else {
//       setState(() {
//         loginState = 1;
//       });
//     }
//   }).catchError((_) {
//     print("catchError");
//   });
// }
