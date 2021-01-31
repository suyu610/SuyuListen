import 'dart:math';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/model/article_model.dart';
import 'package:SuyuListening/ui/animation/FadeAnimation.dart';
import 'package:SuyuListening/utils/color_util.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:badges/badges.dart';
import 'package:flip_card/flip_card.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:random_words/random_words.dart';
import 'package:search_page/search_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Popup/popup.dart';
import 'article_today.dart';

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
  // DateTime _currentDate = new DateTime.now();

  // static Widget _eventIcon = new Container(
  //   decoration: new BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(1000)),
  //       border: Border.all(color: Colors.blue, width: 2.0)),
  //   child: new Icon(
  //     Icons.person,
  //     color: Colors.amber,
  //   ),
  // );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2021, 2, 10): [
        //   new Event(
        //     date: new DateTime(2020, 2, 11),
        //     title: 'Event 1',
        //     icon: _eventIcon,
        //     dot: Container(
        //       margin: EdgeInsets.symmetric(horizontal: 1.0),
        //       color: Colors.red,
        //       height: 5.0,
        //       width: 5.0,
        //     ),
        //   ),
        //   new Event(
        //     date: new DateTime(2021, 2, 12),
        //     title: 'Event 2',
        //     icon: _eventIcon,
        //   ),
        //   new Event(
        //     date: new DateTime(2021, 2, 13),
        //     title: 'Event 3',
        //     icon: _eventIcon,
        //   ),
        // ],
      ],
    },
  );

  int currentMonth = new DateTime.now().month;

  ///
  ///
  AudioPlayer audioPlayer;
  AudioCache audioCache = AudioCache();

  void play() async {
    print("????");

    var bytes = await (await audioCache
            .load('mic/b2db5f04e40c5a3323941afdb8b095ea5844e9a6.mp3'))
        .readAsBytes();
    audioCache.playBytes(bytes);

    // int result = await audioPlayer.play(
    //     "https://files.21voa.com/202101/scientists-find-first-baby-remains-from-tyrannosaurus-group.mp3");
    // if (result == 1) {
    //   // success
    //   print('play success');
    // } else {
    //   print('play failed');
    // }
  }

  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      // success
      print('pause success');
    } else {
      print('pause failed');
    }
  }

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    super.initState();
  }

  jump(startMilliseconds) async {
    int result =
        await audioPlayer.seek(new Duration(milliseconds: startMilliseconds));
    if (result == 1) {
      print('go to success');
      // await audioPlayer.resume();
    } else {
      print('go to failed');
    }
  }

  @override
  void deactivate() async {
    print('结束');
    int result = await audioPlayer.release();
    if (result == 1) {
      print('release success');
    } else {
      print('release failed');
    }
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
      color: Colors.grey.shade100,
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

                  headerTextStyle: TextStyle(color: Colors.black.withAlpha(60)),
                  weekdayTextStyle:
                      TextStyle(color: Colors.black.withAlpha(60)),
                  iconColor: Colors.black.withAlpha(60),
                  // onDayPressed: (DateTime date, List<Event> events) {
                  //   this.setState(() => _currentDate = date);
                  // },
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
                          badgeColor: Colors.grey.shade100,
                          elevation: 0,
                          badgeContent: Icon(
                            Icons.star,
                            size: 20.sp,
                          ),
                          child: Material(
                            color: Color(0xffe74c3c),
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
                              buttonColor: gradientStartColor,
                              describe:
                                  "学习时长为${Random().nextInt(4)}小时\n完成进度:20%");
                        },
                        child: Badge(
                          badgeContent: Icon(
                            Icons.star,
                            size: 20.sp,
                          ),
                          elevation: 0,
                          badgeColor: Colors.grey.shade100,
                          child: Material(
                            color: gradientStartColor,
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
                              buttonColor: gradientStartColor.withAlpha(180),
                              describe:
                                  "学习时长为${Random().nextInt(4)}小时\n完成进度:40%");
                        },
                        child: Material(
                          color: gradientStartColor.withAlpha(180),
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
                              buttonColor: gradientStartColor.withAlpha(100),
                              buttonTitle: "关闭",
                              describe:
                                  "学习时长为${Random().nextInt(4)}小时\n完成进度:24%");
                        },
                        child: Material(
                          color: gradientStartColor.withAlpha(100),
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
                  markedDatesMap: _markedDateMap,
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
                  height: 320.h,
                  width: double.infinity,
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    speed: 500,
                    onFlipDone: (status) {
                      print(status);
                    },
                    front: FadeAnimation(
                      0,
                      TodayArticleListTile(
                        model: new ArticleModel()
                          ..index = 0
                          ..title = generateWordPairs().take(10).join(" ")
                          ..coint = Random().nextInt(10)
                          ..level = Random().nextInt(10)
                          ..learnProgress = Random().nextInt(100)
                          ..downloadValue = 0
                          ..imageUrl = "assets/jupiter.png",
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        color: ThemeColors.colorTheme,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '他的进度 ',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 30.sp),
                              ),
                              Text(
                                '40%',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 30.sp),
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: play,
                          //       child: Icon(
                          //         Icons.speaker,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //     Text(
                          //       "开始学习",
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            width: 240.w,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  color: Colors.black,
                                  onPressed: () => {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Ionicons.flash,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "开始学习",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
                  color: ThemeColors.colorTheme,
                  border: Border.all(width: 3.w),
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
                      primarySwatch:
                          createMaterialColor(ThemeColors.colorTheme),
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

          // Positioned(
          //   right: 100.w,
          //   top: 617.h,
          //   child: SizedBox(
          //     child: FlutterSwitch(
          //       toggleColor: Colors.black,
          //       width: 100.0.w,
          //       height: 40.0.h,
          //       valueFontSize: 15.0.sp,
          //       toggleSize: 20.0.sp,
          //       value: isYourMode,
          //       activeColor: gradientStartColor,
          //       inactiveColor: ThemeColors.colorTheme,
          //       inactiveTextColor: Colors.black.withAlpha(200),
          //       activeText: "me",
          //       inactiveText: "him",
          //       borderRadius: 30.0,
          //       padding: 8.0.w,
          //       showOnOff: true,
          //       onToggle: (val) {
          //         setState(() {
          //           isYourMode = val;
          //         });
          //       },
          //     ),
          //   ),
          // ),

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
                                color: gradientStartColor.withAlpha(100),
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
                                color: gradientStartColor.withAlpha(180),
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
                                  color: gradientStartColor,
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
                                        color: ThemeColors.colorWhite,
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
                                  color: gradientStartColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        offset: Offset(5, 1),
                                        color: Colors.black12)
                                  ]),
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
