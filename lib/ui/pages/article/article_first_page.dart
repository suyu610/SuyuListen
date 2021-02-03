import 'dart:math';
import 'article.dart';

import '../../../model/article_level.dart';
import '../../../constant/theme_color.dart';
import '../../../model/article_model.dart';
import '../../components/animation/fade_animation.dart';
import '../../../utils/color_util.dart';
import '../../components/dialog/popup.dart';

import 'package:badges/badges.dart';
import 'package:flip_card/flip_card.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:search_page/search_page.dart';

class FirstPageWidget extends StatefulWidget {
  const FirstPageWidget({
    this.list,
    Key key,
  }) : super(key: key);
  final List<ArticleModel> list;
  @override
  _FirstPageWidgetState createState() => _FirstPageWidgetState();
}

class _FirstPageWidgetState extends State<FirstPageWidget> {
  int currentMonth = new DateTime.now().month;

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() async {
    super.deactivate();
  }

  void handleCalendarChanged(int date) {
    currentMonth = date;
    setState(() {});
  }

  bool isYourMode = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: 1334.h,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: CalendarCarousel<Event>(
                  pageSnapping: false,

                  locale: ('zh'),
                  headerTextStyle:
                      ThemeProvider.of(context).brightness == Brightness.dark
                          ? TextStyle(color: Colors.white.withAlpha(50))
                          : TextStyle(color: Colors.black.withAlpha(50)),
                  weekdayTextStyle:
                      ThemeProvider.of(context).brightness == Brightness.dark
                          ? TextStyle(color: Colors.white.withAlpha(50))
                          : TextStyle(color: Colors.black.withAlpha(50)),

                  iconColor:
                      ThemeProvider.of(context).brightness == Brightness.dark
                          ? Colors.white.withAlpha(50)
                          : Colors.black.withAlpha(50),

                  isScrollable: false,
                  headerMargin: EdgeInsets.all(0),
                  weekFormat: false,
                  onCalendarChanged: (date) =>
                      handleCalendarChanged(date.month),
                  headerText: isYourMode
                      ? "我的 " + currentMonth.toString() + "月 学习进度"
                      : "他的 " + currentMonth.toString() + "月 学习进度",
                  showOnlyCurrentMonthDate: true,
                  markedDateCustomShapeBorder:
                      CircleBorder(side: BorderSide(color: Colors.black)),
                  // thisMonthDayBorderColor: Colors.black,
                  selectedDayButtonColor: Colors.black,
                  selectedDayBorderColor: Colors.transparent,
                  dayButtonColor: Colors.transparent,
                  selectedDayTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                  todayBorderColor: Colors.transparent,
                  todayButtonColor: Colors.transparent,

                  customDayBuilder: (
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                  ) {
                    if (day.isAfter(DateTime.now())) {
                      return Material(
                        color: Colors.black.withAlpha(10),
                        shape: SuperellipseShape(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        child: Container(
                          height: 90.h,
                          width: 90.h,
                        ),
                      );
                    } else if (day.day == 10 ||
                        day.day == 25 ||
                        day.day == 18) {
                      return GestureDetector(
                        onTap: () {
                          showPopup(context, () => Navigator.pop(context),
                              title: ("${day.month}月${day.day}日"),
                              buttonTitle: "关闭",
                              imageUrl: "assets/images/popup/fail.JPG",
                              buttonColor: Color(0xffe74c3c),
                              describe: "一点也没学习!!");
                        },
                        child: Badge(
                          badgeColor: Theme.of(context).backgroundColor,
                          elevation: 0,
                          badgeContent: Icon(
                            Icons.star,
                            size: 20.sp,
                          ),
                          child: Material(
                            color: Colors.red,
                            shape: SuperellipseShape(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            child: Container(
                                height: 90.h,
                                width: 90.h,
                                child: Icon(
                                    IconData(
                                      0xe6ec,
                                      fontFamily: "appIconFonts",
                                    ),
                                    color: Colors.white)),
                          ),
                        ),
                      );
                    } else if (isToday ||
                        day.day == 18 ||
                        day.day == 13 ||
                        day.day == 7) {
                      return GestureDetector(
                        onTap: () {
                          showPopup(context, () => Navigator.pop(context),
                              buttonTitle: "关闭",
                              title: ("${day.month}月${day.day}日"),
                              buttonColor: blue,
                              describe:
                                  "学习时长为${Random().nextInt(4)}小时\n完成进度:20%");
                        },
                        child: Badge(
                          badgeContent: Icon(
                            Icons.star,
                            size: 20.sp,
                          ),
                          elevation: 0,
                          badgeColor: Theme.of(context).backgroundColor,
                          child: Material(
                            color: blue,
                            shape: SuperellipseShape(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            child: Container(
                              height: 90.h,
                              width: 90.h,
                              child: Center(
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 34.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (day.day == 1 || day.day == 5 || day.day == 19) {
                      return GestureDetector(
                        onTap: () {
                          showPopup(context, () => Navigator.pop(context),
                              buttonTitle: "关闭",
                              title: ("${day.month}月${day.day}日"),
                              buttonColor: blue.withAlpha(180),
                              describe:
                                  "学习时长为${Random().nextInt(4)}小时\n完成进度:40%");
                        },
                        child: Material(
                          color: blue.withAlpha(180),
                          shape: SuperellipseShape(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                          child: Container(
                            height: 90.h,
                            width: 90.h,
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          showPopup(context, () => Navigator.pop(context),
                              title: ("${day.month}月${day.day}日"),
                              buttonColor: blue.withAlpha(100),
                              buttonTitle: "关闭",
                              describe:
                                  "学习时长为${Random().nextInt(4)}小时\n完成进度:24%");
                        },
                        child: Material(
                          color: blue.withAlpha(100),
                          shape: SuperellipseShape(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                          child: Container(
                            height: 90.h,
                            width: 90.h,
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  // weekDayMargin: EdgeInsets.zero,
                  markedDateIconMargin: 0,
                  height: 675.0.h,
                  // selectedDateTime: _currentDate,
                  daysHaveCircularBorder: false,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(right: 10.0, left: 10, bottom: 10),
                  child: Row(children: <Widget>[
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Text(
                        "今日文章",
                        style: TextStyle(color: Colors.black.withAlpha(60)),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ])),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10),
                child: Container(
                  height: 300.h,
                  width: double.infinity,
                  child: FlipCard(
                      direction: FlipDirection.VERTICAL,
                      speed: 500,
                      onFlipDone: (status) {
                        print(status);
                      },
                      front: FadeAnimation(
                        0,
                        TodayArticleFrontWidget(
                          model: new ArticleModel()
                            ..title = "title"
                            ..coint = Random().nextInt(10)
                            ..level = randomLevel()
                            ..learnProgress = Random().nextInt(100)
                            ..downloadValue = 0
                            ..imageUrl = "assets/jupiter.png",
                        ),
                      ),
                      back: TodayArticleBackWidget()),
                ),
              ),
            ],
          ),
          Positioned(
            right: -3.h,
            bottom: -3.h,
            child: Container(
              height: 90.h,
              width: 90.h,
              decoration: BoxDecoration(
                  color: yellow,
                  // border: Border.all(width: 3.w),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.h),
                  )),
              child: IconButton(
                icon: Icon(Icons.search),
                tooltip: '搜索单词',
                onPressed: () => showSearch(
                  context: context,
                  delegate: SearchPage<ArticleModel>(
                    barTheme: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      primarySwatch: createMaterialColor(yellow),
                    ),
                    items: widget.list,
                    searchLabel: 'Search Word',
                    suggestion: Center(
                      child: Text('搜索单词'),
                    ),
                    failure: Center(
                      child: Text('No Word found :('),
                    ),
                    filter: (list) => [
                      list.title,
                      list.coint.toString(),
                    ],
                    builder: (list) => ListTile(
                      title: Text(list.title),
                      subtitle: Text(
                        list.coint.toString(),
                      ),
                      trailing: Text('${list.coint.toString()}'),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// 图示
          // 右下角图示
          Positioned(
            right: 0.w,
            top: 600.h,
            child: IconButton(
              icon: Icon(
                Ionicons.information_outline,
                color: Colors.grey.withAlpha(100),
              ),
              onPressed: () => {
                showMaterialModalBottomSheet(
                  expand: false,
                  context: context,
                  bounce: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(
                    height: 600.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(36.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "学习进度的图示",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Material(
                                color: Color(0xffe74c3c),
                                shape: SuperellipseShape(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                child: Container(
                                  height: 60.h,
                                  width: 60.h,
                                  child: Center(
                                    child: Icon(
                                        IconData(0xe6ec,
                                            fontFamily: "appIconFonts"),
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Text(
                                "x 5",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              SizedBox(width: 250.w, child: Text("学习进度 < 30%")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Material(
                                color: blue.withAlpha(100),
                                shape: SuperellipseShape(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                child: Container(
                                  height: 60.h,
                                  width: 60.h,
                                  child: Center(
                                    child: Text(
                                      "x",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "x 15",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              SizedBox(width: 250.w, child: Text("学习进度 > 30%")),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Material(
                                color: blue.withAlpha(180),
                                shape: SuperellipseShape(
                                  borderRadius: BorderRadius.circular(28.0),
                                ),
                                child: Container(
                                  height: 60.h,
                                  width: 60.h,
                                  child: Center(
                                    child: Text(
                                      "x",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "x 5",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              SizedBox(width: 250.w, child: Text("学习进度 > 60%")),
                            ],
                          ),

                          ///他的标志
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Badge(
                                badgeColor: Colors.white,
                                elevation: 0,
                                badgeContent: Icon(
                                  Icons.star,
                                  size: 20.sp,
                                ),
                                child: Material(
                                  color: blue,
                                  shape: SuperellipseShape(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  child: Container(
                                    height: 60.h,
                                    width: 60.h,
                                    child: Center(
                                      child: Icon(
                                        Icons.star,
                                        // IconData(0xe600, fontFamily: "appIconFonts"),
                                        color: colorWhite,
                                        size: 34.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "x 6",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              SizedBox(
                                  width: 250.w, child: Text("全部学完\n右上角表示他已学完")),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 70.h,
                              width: 300,
                              padding: const EdgeInsets.all(10.0),
                              // margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "知道了",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
