import 'dart:async';
import 'dart:math';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/model/article_model.dart';
import 'package:SuyuListening/provider/theme_provider.dart';
import 'package:SuyuListening/sample_data/data.dart';
import 'package:SuyuListening/ui/animation/FadeAnimation.dart';
import 'package:badges/badges.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart' as icon_2;
import 'package:random_words/random_words.dart';
import 'article_detail.dart';

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
            ..index = index
            ..title = generateWordPairs().take(10).join(" ")
            ..coint = Random().nextInt(10)
            ..level = Random().nextInt(10)
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
          ..index = 10
          ..title = generateWordPairs().take(10).join(" ")
          ..coint = Random().nextInt(10)
          ..level = Random().nextInt(10)
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
        ..index = index
        ..title = generateWordPairs().take(10).join(" ")
        ..coint = Random().nextInt(10)
        ..level = Random().nextInt(10)
        ..learnProgress = Random().nextInt(100)
        ..downloadValue = 0
        ..imageUrl = coverImageList[Random().nextInt(coverImageList.length)];
    });
    _scrollController = new ScrollController();

    _pageController = PageController();

    // 应该只让他监听一次
    _pageController.addListener(() {
      double offset = _pageController.offset;
      double page = _pageController.page;
      if (page == 0 && offset < -10) {
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
            "文章列表",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 36.sp),
          ),
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
                    badgeColor: ThemeColors.colorTheme,
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
                GestureDetector(
                  onTap: () => EasyLoading.showSuccess("你的积分为"),
                  child: Row(
                    children: [
                      Icon(
                        icon_2.Ionicons.flower_outline,
                        color: Colors.black,
                        size: 40.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          "15",
                          maxLines: 1,
                          // textVerticleAlign: TextAlignVertical.center,
                          style: TextStyle(
                            fontSize: 34.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            onTap: _changeTab,
            tabs: columnList.map((f) {
              return FadeAnimation(
                  1,
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8, top: 4, bottom: 4),
                      child: Text(
                        f,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30.sp, color: Colors.black),
                      ),
                    ),
                  ));
            }).toList(),
            controller: _tabController,
            indicator: BoxDecoration(
                color: ThemeColors.colorTheme.withAlpha(90),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorColor: gradientStartColor,
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

// ignore: must_be_immutable
class ArticleListTile extends StatefulWidget {
  const ArticleListTile({
    this.model,
    Key key,
  }) : super(key: key);
  final ArticleModel model;
  @override
  _ArticleListTileState createState() => _ArticleListTileState();
}

class _ArticleListTileState extends State<ArticleListTile> {
  ArticleModel model;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  void tapBookMark() {
    EasyLoading.showSuccess(model.isMark ? "取消收藏" : "已收藏");
    model.isMark = !model.isMark;
    setState(() {});
  }

  void tapDownloadingButton() {
    if (model.isDownloading) {
      EasyLoading.showError("取消下载");
      // 取消下载
      model.downloadValue = 0;
    } else {
      const timeout = const Duration(milliseconds: 100);

      Timer.periodic(timeout, (timer) {
        model.downloadValue += 0.01;
        if (model.downloadValue >= 1) {
          timer.cancel();
          EasyLoading.showSuccess("下载完成");
        }
        setState(() {});
      });
    }
    model.isDownloading = !model.isDownloading;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticleDetailPage();
        }))
      },
      onLongPress: () => {
        CoolAlert.show(
            backgroundColor: ThemeColors.colorTheme,
            context: context,
            confirmBtnColor: ThemeColors.colorTheme,
            confirmBtnTextStyle: TextStyle(color: Colors.black),
            type: CoolAlertType.confirm,
            lottieAsset: "assets/lotties/lf30_editor_obrqtkg5.json",
            title: "确认删除吗?",
            confirmBtnText: "确认",
            cancelBtnText: "取消",
            cancelBtnTextStyle: TextStyle(color: Colors.black),
            onConfirmBtnTap: () async {
              // list.removeAt(index);
              setState(() {});
              Navigator.pop(context);
              EasyLoading.showSuccess("删除成功");
            })
      },
      child: Container(
        height: 300.h,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: gradientStartColor,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(model.imageUrl),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 10,
                  offset: Offset(0, 10))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 标题
                      FadeAnimation(
                          1,
                          Text(
                            model.title,
                            maxLines: 2,
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Colors.black54,
                                      blurRadius: 4,
                                      offset: Offset(0, 0))
                                ],
                                color: Colors.white,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      // 积分
                      FadeAnimation(
                          1.1,
                          Container(
                            // padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                            width: 100.w,
                            // color: Colors.black38,
                            child: Row(
                              children: [
                                Icon(
                                  icon_2.Ionicons.flower,
                                  size: 30.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  model.coint.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 34.sp),
                                ),
                              ],
                            ),
                          )),
                      // 难度
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: FadeAnimation(
                          1.1,
                          RatingBar(
                            rating: 3,
                            icon: Icon(
                              Icons.star,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                            color: gradientEndColor,
                            starCount: 5,
                            spacing: 1.0.w,
                            size: 30.w,
                            isIndicator: true,
                            allowHalfRating: true,
                            onRatingCallback: (double value,
                                ValueNotifier<bool> isIndicator) {
                              print('Number of stars-->  $value');
                              //change the isIndicator from false  to true ,the       RatingBar cannot support touch event;
                              isIndicator.value = true;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeAnimation(
                    1.2,
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => tapDownloadingButton(),
                          child: model.isDownloading
                              ? Container(
                                  margin: EdgeInsets.only(left: 10),
                                  height: 55.h,
                                  width: 55.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: model.downloadValue < 1
                                          ? Colors.white
                                          : ThemeColors.colorTheme),
                                  child: model.downloadValue < 1
                                      ? Center(
                                          child:
                                              LiquidCircularProgressIndicator(
                                            value: model
                                                .downloadValue, // Defaults to 0.5.
                                            valueColor: AlwaysStoppedAnimation(
                                                ThemeColors
                                                    .colorTheme), // Defaults to the current Theme's accentColor.
                                            backgroundColor: Colors
                                                .transparent, // Defaults to the current Theme's backgroundColor.
                                            direction: Axis
                                                .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                            center: Text(
                                              (model.downloadValue * 100)
                                                      .toInt()
                                                      .toString() +
                                                  "%",
                                              style: TextStyle(fontSize: 22.sp),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Icon(
                                            icon_2.Ionicons.checkmark,
                                            color: Colors.black,
                                            size: 36.sp,
                                          ),
                                        ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width: 55.h,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Center(
                                    child: Icon(
                                      icon_2.Ionicons.cloud_download_outline,
                                      size: 36.sp,
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () => tapBookMark(),
                          child: Container(
                            width: 55.h,
                            height: 55.h,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: model.isMark
                                    ? ThemeColors.colorTheme
                                    : Colors.white),
                            child: Center(
                              child: Icon(
                                Icons.bookmark_border_rounded,
                                color: Colors.black,
                                size: 36.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            // 进度
            FadeAnimation(
                1.3,
                Text(
                  model.learnProgress.toString() + "%",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
