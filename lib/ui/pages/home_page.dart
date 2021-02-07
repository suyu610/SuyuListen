import 'package:SuyuListening/config/global.dart';

import 'slider_menu/slider_menu_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'article/article_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  DateTime _lastTime; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastTime == null ||
            DateTime.now().difference(_lastTime) > Duration(seconds: 1)) {
          //两次点击间隔超过1s重新计时
          _lastTime = DateTime.now();
          EasyLoading.showToast("再点一次退出应用");
          return false;
        }
        return true;
      },
      child: InnerDrawer(
        key: Global.innerDrawerKey,
        leftChild: _buildLeftChild(context),
        scaffold: ArticleListPage(),
        // 一些配置
        onTapClose: true,
        swipe: true,
        colorTransitionChild: Colors.white,
        colorTransitionScaffold: Colors.white.withAlpha(100),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0), blurRadius: 5)
        ],
        proportionalChildArea: true,
        tapScaffoldEnabled: false,
        borderRadius: 0,
        leftAnimationType: InnerDrawerAnimation.linear,
        innerDrawerCallback: (a) => {},
      ),
    );
  }
}

Widget _buildLeftChild(BuildContext context) {
  return GestureDetector(
      onHorizontalDragEnd: (detail) {
        // 同时也关掉search bar
        Global.floatingSearchBarKey.currentState.close();
        print("??");
        Global.innerDrawerKey.currentState
            .toggle(direction: InnerDrawerDirection.start);
      },
      child: MenuWidget());
}
