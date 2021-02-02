import 'dart:async';
import 'dart:math';

import '../../../constant/theme_color.dart';
import '../../../model/article_level.dart';
import '../../../model/article_model.dart';
import '../../../provider/theme_provider.dart';
import '../../../sample_data/data.dart';
import '../../../ui/animation/fade_animation.dart';
import '../../../ui/components/article_list_tile.dart';
import '../../../ui/components/first_page_widget.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart' as icon_2;
import 'package:random_words/random_words.dart';

class ArticleListPage extends StatefulWidget {
  ArticleListPage({Key key}) : super(key: key);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  TabController _tabController;
  PageController _pageController;
  ScrollController _scrollController;
  EasyRefreshController easyRefreshController;
  List coverImageList = [
    "assets/jupiter.png",
    "assets/earth.png",
    "assets/mars.png",
    "assets/neptune.png",
    "assets/saturn.png",
    "assets/uranus.png"
  ];
  List<ArticleModel> list;
  Future _onRefresh() async {
    double value = 0;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (value < 0.95) {
        value += 0.01;
        // EasyLoading.showProgress(value,
        //     status: '加载中...', maskType: EasyLoadingMaskType.black);
      } else {
        timer.cancel();
        list.clear();
        int count = Random().nextInt(10) + 1;

        list = List.generate(count, (index) {
          return new ArticleModel()
            ..title = generateWordPairs().take(10).join(" ")
            ..coint = Random().nextInt(10)
            ..level = randomLevel()
            ..learnProgress = Random().nextInt(100)
            ..downloadValue = 0
            ..imageUrl =
                coverImageList[Random().nextInt(coverImageList.length)];
        });
        EasyLoading.showSuccess("加载完成");
        setState(() {});
        easyRefreshController.resetLoadState();
      }
    });
  }

  Future _onLoading() async {
    // EasyLoading.showProgress(0,
    //     status: "加载中", maskType: EasyLoadingMaskType.black);
    if (list.length >= 15) {
      // EasyLoading.showError("已经加载全部");
      easyRefreshController.finishLoad(success: false, noMore: true);
    } else {
      await Future.delayed(Duration(milliseconds: 1000), () {
        list.add(new ArticleModel()
          ..title = generateWordPairs().take(10).join(" ")
          ..coint = Random().nextInt(10)
          ..level = randomLevel()
          ..learnProgress = Random().nextInt(100)
          ..downloadValue = 0
          ..imageUrl = coverImageList[Random().nextInt(coverImageList.length)]);
        setState(() {});
        easyRefreshController.finishLoad(success: true);
      });
    }

    // EasyLoading.dismiss();
  }

  void _changeTab(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int index) {
    print(index);
    _tabController.animateTo(index, duration: Duration(milliseconds: 300));
  }

  @override
  void initState() {
    super.initState();
    easyRefreshController = EasyRefreshController();

    list = List.generate(10, (index) {
      return new ArticleModel()
        ..title = generateWordPairs().take(10).join(" ")
        ..coint = Random().nextInt(10)
        ..level = randomLevel()
        ..learnProgress = Random().nextInt(100)
        ..downloadValue = 0
        ..imageUrl = coverImageList[Random().nextInt(coverImageList.length)];
    });
    _scrollController = new ScrollController();

    _pageController = PageController();

    DateTime _lastTime; //上次滑动的时间

    // 应该只让他监听一次
    _pageController.addListener(() {
      double offset = _pageController.offset;
      double page = _pageController.page;

      if (page == 0 &&
          offset < -10 &&
          (_lastTime == null ||
              DateTime.now().difference(_lastTime) > Duration(seconds: 1))) {
        //两次点击间隔超过1s重新计时
        _lastTime = DateTime.now();
        Provider.of<ThemeProvider>(context, listen: false)
            .innerDrawerKey
            .currentState
            .open(direction: InnerDrawerDirection.start);
      }
    });

    _tabController = TabController(
      length: columnList.length,
      vsync: ScrollableState(),
    );
    _tabController.addListener(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  bool hasNewMsg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () => {
              Provider.of<ThemeProvider>(context, listen: false)
                  .innerDrawerKey
                  .currentState
                  .toggle(direction: InnerDrawerDirection.start)
            },
            child: Icon(
              icon_2.Ionicons.menu_outline,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "素语听力",
            style: TextStyle(color: Colors.black, fontSize: 30.sp),
            textAlign: TextAlign.center,
          ),
          // Image.asset(
          //   "assets/images/bg.png",
          //   fit: BoxFit.fill,
          // ),
          brightness: Brightness.light,
          actions: <Widget>[
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    hasNewMsg = !hasNewMsg;
                    setState(() {});
                  },
                  child: Badge(
                    elevation: 0,
                    shape: BadgeShape.circle,
                    badgeColor: yellow,
                    showBadge: hasNewMsg,
                    position: BadgePosition.topEnd(top: 1, end: 1),
                    animationDuration: Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    toAnimate: true,
                    badgeContent: null,
                    child: Icon(
                      icon_2.Ionicons.notifications_outline,
                      color: Colors.black,
                      size: 40.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Icon(
                  icon_2.Ionicons.cloud_download_outline,
                  color: Colors.black,
                  size: 40.sp,
                ),
                SizedBox(
                  width: 30.w,
                ),
              ],
            ),
          ],
          bottom: TabBar(
            onTap: _changeTab,
            tabs: columnList.map((f) {
              if (f == "首页") {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.home, color: Colors.black),
                );
              }
              return Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 8, top: 4, bottom: 4),
                  child: Text(
                    f,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              );
            }).toList(),
            controller: _tabController,
            indicator: BoxDecoration(
                color: yellow.withAlpha(90),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorColor: blue,
            labelStyle: TextStyle(height: 3.h, color: Colors.white),
          ),
        ),
        // appBar: AppBar(
        // ),
        body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PageView.builder(
                itemCount: columnList.length,
                onPageChanged: _onPageChanged,
                controller: _pageController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return FirstPageWidget(list: list);
                  }
                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: EasyRefresh(
                      header: DeliveryHeader(
                        backgroundColor: Colors.transparent,
                      ),
                      footer: ClassicalFooter(
                        // infoText: "6",
                        noMoreText: "没有",
                        loadFailedText: "失败",
                        loadedText: "加载完成",
                        // noMoreText: "4",
                        loadingText: "加载中...",
                        // loadReadyText: "1",
                        // loadText: "2",
                      ),
                      onRefresh: _onRefresh,
                      onLoad: _onLoading,
                      child: ListView.builder(
                        itemCount: list.length,
                        physics: NeverScrollableScrollPhysics(),
                        controller: _scrollController,
                        //范围内进行包裹（内容多高ListView就多高）
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FadeAnimation(
                            0,
                            ArticleListTile(
                              model: list[index],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                })));
  }
}
