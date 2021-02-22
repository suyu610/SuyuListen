import 'package:SuyuListening/config/global.dart';
import 'package:SuyuListening/net/post_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'slider_menu/slider_menu_page.dart';
import 'package:SuyuListening/db/dao/article_dao.dart';
import 'package:SuyuListening/entity/entities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'article/article_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleDAO articleDAO;
  List<ArticleEntity> list;
  void getList() async {}

  Future<List<ArticleEntity>> getUpdate() async {
    PostApi postApi = PostApi.instance;
    list = await postApi.getUpdateAPI(1613010188308);

    // 插到数据库中
    list.forEach((element) {
      articleDAO.insert(element);
    });

    return list;
  }

  @override
  void initState() {
    articleDAO = new ArticleDAO();
    // print(articleDAO.deleteAllArticle());
    // getUpdate();
    // getList();
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

        scaffold: FutureBuilder(
            future: getUpdate(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ArticleEntity>> snapshot) {
              if (snapshot.hasData) {
                return ArticleListPage(snapshot.data);
              } else {
                return SpinKitFadingCircle(
                  color: Colors.black,
                  size: 30.0,
                );
              }
            }),
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
        Global.innerDrawerKey.currentState
            .toggle(direction: InnerDrawerDirection.start);
      },
      child: MenuWidget());
}
