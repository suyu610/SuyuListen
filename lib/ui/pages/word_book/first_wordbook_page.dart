import 'dart:math';

import 'package:SuyuListening/controller/wordbook_controller.dart';
import 'package:SuyuListening/entity/entities.dart';
import 'package:SuyuListening/entity/word/user_word_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_shape.dart';

class FirstWordBookPage extends StatefulWidget {
  FirstWordBookPage(this.floatingSearchBarController, {Key key})
      : super(key: key);
  final FloatingSearchBarController floatingSearchBarController;

  @override
  FirstWordBookPageState createState() => FirstWordBookPageState();
}

class FirstWordBookPageState extends State<FirstWordBookPage> {
  WordBookController wordBookController;
  final double _borderRadius = 14;

  @override
  void initState() {
    wordBookController =
        Provider.of<WordBookController>(context, listen: false);

    super.initState();
  }

  var colorItems = [
    RandomGradientColor(Color(0xff6DC8F3), Color(0xff73A1F9)),
    RandomGradientColor(Color(0xffFFB157), Color(0xffFFA057)),
    RandomGradientColor(Color(0xffFF5B95), Color(0xffF8556D)),
  ];

  @override
  Widget build(BuildContext context) {
    // 在时间内，应该只让他监听一次
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 100.h),
      // 滚动监听
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            wordBookController.onUpdateScroll(scrollNotification.metrics);
          }
          // 不拦截
          return false;
        },
        child: FutureBuilder(
            future: wordBookController.loadWordLisk(),
            builder: (BuildContext context,
                AsyncSnapshot<List<UserWordEntity>> snapshot) {
              if (snapshot.hasData) {
                List<UserWordEntity> list = snapshot.data;
                return ListView.builder(
                  controller: wordBookController.scrollController,
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  itemCount:
                      list.length, //wordBookController.wordBookList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        wordBookController.onTapListTile(index, context);
                      },
                      child: Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 7.0),
                          child: Stack(
                            children: <Widget>[
                              Material(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: SuperellipseShape(
                                    borderRadius: BorderRadius.circular(40)),
                                child: Container(
                                  height: 150.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          colorItems[index % 3].startColor,
                                          colorItems[index % 3].endColor
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                top: 0,
                                child: CustomPaint(
                                  size: Size(100, 150),
                                  painter: CustomCardShapePainter(
                                      _borderRadius,
                                      colorItems[index % 3].startColor,
                                      colorItems[index % 3].endColor),
                                ),
                              ),
                              Positioned.fill(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Provider.of<WordBookController>(
                                                  context,
                                                  listen: true)
                                              .wordBookList[index]
                                              .tempIsCompelete
                                          ? Icon(Icons.check,
                                              color: Colors.white, size: 30)
                                          : Icon(Icons.radio_button_unchecked,
                                              color: Colors.white, size: 30),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          AnimatedOpacity(
                                            opacity: Provider.of<WordBookController>(
                                                                context,
                                                                listen: true)
                                                            .showDefinitionMode !=
                                                        DefinitinoEnum.CH ||
                                                    Provider.of<WordBookController>(
                                                            context,
                                                            listen: true)
                                                        .wordBookList[index]
                                                        .tempIsCompelete
                                                ? 1.0
                                                : 0.0,
                                            duration:
                                                Duration(milliseconds: 500),
                                            child: Text(
                                              list[index].word,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 44.sp,
                                                  color: Colors.white,
                                                  fontFamily: 'Avenir',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(height: 16.h),
                                          AnimatedOpacity(
                                            opacity: Provider.of<WordBookController>(
                                                                context,
                                                                listen: true)
                                                            .showDefinitionMode !=
                                                        DefinitinoEnum.ENG ||
                                                    Provider.of<WordBookController>(
                                                            context,
                                                            listen: true)
                                                        .wordBookList[index]
                                                        .tempIsCompelete
                                                ? 1.0
                                                : 0.0,
                                            duration:
                                                Duration(milliseconds: 500),
                                            child: Text(
                                              list[index].definition,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 28.sp,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.headset_mic_rounded,
                                            size: 30.sp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Icon(
                                            Ionicons.chevron_forward,
                                            size: 34.sp,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFadingCircle(
                      color: Colors.black,
                      size: 30.0,
                    ),
                    Text("加载中"),
                  ],
                );
              }
            }),
      ),
    );
  }
}
