import 'dart:async';
import 'dart:ui';

import 'package:SuyuListening/config/global.dart';
import 'package:SuyuListening/entity/article/user_article_entity.dart';
import 'package:SuyuListening/ui/components/bubble/bubble_widget.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../constant/theme_color.dart';
import '../../../entity/article/article_entity.dart';
import '../../../sample_data/data.dart';
import '../../components/animation/fade_animation.dart';
import 'article_finish_list_tile.dart';
import 'article_list_tile.dart';
import 'article_first_page.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart' as icon_2;

class ArticleListPage extends StatefulWidget {
  ArticleListPage(this.list, {Key key}) : super(key: key);
  final List<ArticleEntity> list;
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
  List<UserArticleEntity> list;
  Future _onRefresh() async {
    double value = 0;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (value < 0.95) {
        value += 0.01;
        // EasyLoading.showProgress(value,
        //     status: '加载中...', maskType: EasyLoadingMaskType.black);
      } else {
        timer.cancel();
        // list.clear();
        // int count = Random().nextInt(10) + 1;
        // list = List.generate(count, (index) {
        //   return new UserArticleEntity()
        //     ..studyProgress = Random().nextInt(100)
        //     ..downloadValue = 0
        //     ..articleEntity = new ArticleEntity(
        //         title: "title",
        //         coins: Random().nextInt(10),
        //         level: randomLevel(),
        //         imageUrl:
        //             coverImageList[Random().nextInt(coverImageList.length)]);
        // });
        EasyLoading.showSuccess("加载完成");
        setState(() {});
        easyRefreshController.resetLoadState();
      }
    });
  }

  Future _onLoading() async {}

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
    list = [];
    easyRefreshController = EasyRefreshController();

    _scrollController = new ScrollController();
    widget.list.forEach((element) {
      list.add(UserArticleEntity(articleEntity: element));
    });

    _pageController = PageController();

    DateTime _lastTime; //上次滑动的时间

    // 应该只让他监听一次
    _pageController.addListener(() {
      double offset = _pageController.offset;
      double page = _pageController.page;

      if (page == 0 &&
          offset < -40 &&
          (_lastTime == null ||
              DateTime.now().difference(_lastTime) > Duration(seconds: 1))) {
        //两次点击间隔超过1s重新计时
        _lastTime = DateTime.now();
        Global.innerDrawerKey.currentState
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () => {
              Global.innerDrawerKey.currentState
                  .toggle(direction: InnerDrawerDirection.start)
            },
            child: Icon(
              Icons.menu,
              // color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            "素语听力",
            style: kTitleTextStyle,
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
                      size: 40.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Icon(
                  icon_2.Ionicons.cloud_download_outline,
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
                  child: Icon(Icons.home),
                );
              }
              if (f == "对局信息") {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.person),
                );
              }
              return Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 8, top: 4, bottom: 4),
                  child: Text(
                    f,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
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
            labelStyle: TextStyle(height: 3.h),
          ),
        ),
        // appBar: AppBar(
        // ),
        body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PageView(
                onPageChanged: _onPageChanged,
                controller: _pageController,
                physics: BouncingScrollPhysics(),
                children: [
                  FirstPageWidget(list: list),
                  Container(
                    child: Center(
                      child: Text("对局信息"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        itemCount: list.length,
                        physics: NeverScrollableScrollPhysics(),
                        controller: _scrollController,
                        //范围内进行包裹（内容多高ListView就多高）
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FadeAnimation(
                            0,
                            ArticleFinishListTile(
                              model: list[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: EasyRefresh(
                      header: DeliveryHeader(
                        backgroundColor: Theme.of(context).backgroundColor,
                      ),
                      footer: ClassicalFooter(
                        noMoreText: "没有",
                        loadFailedText: "失败",
                        loadedText: "加载完成",
                        loadingText: "加载中...",
                      ),
                      onRefresh: _onRefresh,
                      onLoad: _onLoading,
                      child: GroupedListView<dynamic, String>(
                        elements: list,
                        groupBy: (element) => element.articleEntity.topic,
                        shrinkWrap: true,
                        groupSeparatorBuilder: (String groupByValue) => Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                                color: yellow,
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 5, bottom: 5),
                              child: Text(
                                "话题:  " + groupByValue,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                        indexedItemBuilder:
                            (context, dynamic element, int index) =>
                                FadeAnimation(
                          0,
                          ArticleListTile(
                            model: list[index],
                          ),
                        ),
                        itemComparator: (item1, item2) => item1
                            .articleEntity.topic
                            .compareTo(item2.articleEntity.topic), // optional
                        useStickyGroupSeparators: false, // optional
                        floatingHeader: false, // optional
                        order: GroupedListOrder.ASC, // optional
                      ),
                    ),
                  ),
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      buildBackground(),
                      buildBlurWidget(),
                      Container(
                        color: Colors.transparent,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BorderedText(
                              strokeColor: black,
                              strokeWidth: 6.0,
                              child: Text(
                                'under',
                                style: TextStyle(
                                  color: white,
                                  fontFamily: 'gta5Fonts',
                                  fontSize: 60,
                                  fontWeight: FontWeight.normal,
                                  // letterSpacing: 2,
                                  decoration: TextDecoration.none,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  decorationColor: Colors.red,
                                ),
                              ),
                            ),
                            BorderedText(
                              strokeColor: black,
                              strokeWidth: 6.0,
                              child: Text(
                                'Development',
                                style: TextStyle(
                                  color: Color(0xfff2001b),
                                  fontSize: 50,
                                  fontFamily: 'gta5Fonts',
                                  fontWeight: FontWeight.normal,
                                  // letterSpacing: 2,
                                  decoration: TextDecoration.none,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  decorationColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        )
                            // child: BorderedText(
                            //   child:Text("开发中"),
                            //   style: TextStyle(
                            //       color: black, fontSize: 60, fontWeight: FontWeight.bold),
                            // ),
                            ),
                      ),
                      BubbleWidget(),
                    ],
                  )
                ])));
  }

  buildBackground() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xffffa289), //#ffa289
              Color(0xffd07923), //#d07923
              Color(0xffaa2b25), //#aa2b25
            ])),
      );
  buildBlurWidget() => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
        child: Container(
          color: Colors.white.withOpacity(0.1),
        ),
      );
}
