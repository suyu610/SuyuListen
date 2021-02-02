import 'package:SuyuListening/provider/listen_provider.dart';
import 'package:SuyuListening/provider/theme_provider.dart';
import 'package:SuyuListening/ui/components/no_splash.dart';
import 'package:SuyuListening/ui/pages/article/article_detail.dart';
import 'package:SuyuListening/ui/pages/splash/splash_screen.dart';
import 'package:SuyuListening/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/global.dart';
import 'constant/theme_color.dart';
// import 'ui/pages/listen.dart';

void main() async {
  // 状态栏颜色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );

  // 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Global.init().then((value) => runApp(
        MultiProvider(providers: [
          ListenableProvider<ListenProvider>(
            create: (_) => ListenProvider(),
          ),
          ListenableProvider<ThemeProvider>(
              create: (_) => ThemeProvider(LIGHT)),
        ], child: MyApp()),
      ));
}

// ignore: non_constant_identifier_names
final ThemeData LIGHT = ThemeData(
  scaffoldBackgroundColor: colorWhite,
  backgroundColor: colorWhite,
  dialogBackgroundColor: yellow,

  primaryColor: yellow,
  splashColor: Colors.transparent,
  splashFactory: NoSplashFactory(),
  highlightColor: Colors.transparent,
  textSelectionColor: Colors.black,
  // primarySwatch: Colors.blue,
  accentColor: Colors.black,
  hintColor: Colors.black,
  primaryIconTheme: IconThemeData(color: colorBlack),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: true,
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: createMaterialColor(colorBlack),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StartAppPage(title: '文章列表'),
      ),
    );
  }
}

class StartAppPage extends StatefulWidget {
  StartAppPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StartAppPageState createState() => _StartAppPageState();
}

class _StartAppPageState extends State<StartAppPage> {
  var loginState;

  @override
  void initState() {
    _validateLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return ArticleDetailPage();

    // return ListenPage();
    return SplashScreen();
    // if (loginState == 0) {
    //   return WelcomePage();
    // } else {
    //   return HomePage();
    // }
  }

  Future _validateLogin() async {
    Future<dynamic> future = Future(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("loginToken");
    });
    future.then((val) {
      if (val == null) {
        setState(() {
          loginState = 0;
        });
      } else {
        setState(() {
          loginState = 1;
        });
      }
    }).catchError((_) {
      print("catchError");
    });
  }
}
