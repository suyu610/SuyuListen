import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/controller/wordbook_controller.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_shape.dart';

class FirstWordBookPage extends StatefulWidget {
  FirstWordBookPage({Key key}) : super(key: key);
  @override
  FirstWordBookPageState createState() => FirstWordBookPageState();
}

class FirstWordBookPageState extends State<FirstWordBookPage> {
  WordBookController cFalse;
  WordBookController cTrue;

  final double _borderRadius = 14;
  @override
  void initState() {
    cFalse = Provider.of<WordBookController>(context, listen: false);
    cTrue = Provider.of<WordBookController>(context, listen: false);
    super.initState();
  }

  List<RandomGradientColor> colorItems = [
    RandomGradientColor(Color(0xfffff3d2), Color(0xfffff3d2)),
    RandomGradientColor(Color(0xffbdefed), Color(0xffbdefed)),
  ];

  // var colorList = [yellow, red, blue, orange, green];

  @override
  Widget build(BuildContext context) {
    // 在一定时间内，应该只让他监听一次
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 100.h),
        // 滚动监听
        child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                cFalse.onUpdateScroll(scrollNotification.metrics);
              }
              // 不拦截
              return false;
            },
            child: Provider.of<WordBookController>(context, listen: true)
                        .wordBookList
                        .length !=
                    0
                ? ListView.builder(
                    padding: EdgeInsets.fromLTRB(10.w, 4, 10.w, 4),
                    scrollDirection: Axis.vertical,
                    controller:
                        Provider.of<WordBookController>(context, listen: true)
                            .scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount:
                        Provider.of<WordBookController>(context, listen: true)
                            .wordBookList
                            .length, //
                    itemBuilder: (context, index) => wordbookListItem(
                        context, index, colorItems, _borderRadius))
                : Center(
                    child: Text("单词表为空"),
                  )));
  }

  Widget wordbookListItem(BuildContext context, int index,
      List<RandomGradientColor> colorItems, double _borderRadius) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
        child: Stack(
          children: <Widget>[
            Material(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: SuperellipseShape(borderRadius: BorderRadius.circular(40)),
              child: Container(
                height: 150.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [silver, silver],
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
                painter: CustomCardShapePainter(_borderRadius, silver, silver),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("..");
                      },
                      child:
                          Provider.of<WordBookController>(context, listen: true)
                                  .wordBookList[index]
                                  .tempIsCompelete
                              ? Icon(Icons.check, color: green, size: 50.sp)
                              : Icon(Icons.radio_button_unchecked,
                                  color: red, size: 50.sp),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 6,
                    child: GestureDetector(
                      onTap: () {
                        cFalse.onTapListTile(index, context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AnimatedOpacity(
                            opacity:
                                cTrue.showDefinitionMode != DefinitinoEnum.CH ||
                                        Provider.of<WordBookController>(context,
                                                listen: true)
                                            .wordBookList[index]
                                            .tempIsCompelete
                                    ? 1.0
                                    : 0.0,
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              cTrue.wordBookList[index].word,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 44.sp,
                                  color: black,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AnimatedOpacity(
                            opacity: cTrue.showDefinitionMode !=
                                        DefinitinoEnum.ENG ||
                                    Provider.of<WordBookController>(context,
                                            listen: true)
                                        .wordBookList[index]
                                        .tempIsCompelete
                                ? 1.0
                                : 0.0,
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              Provider.of<WordBookController>(context,
                                      listen: true)
                                  .wordBookList[index]
                                  .definition,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: black,
                                fontSize: 28.sp,
                                fontFamily: 'Avenir',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cFalse.tapPlayAudioButton(
                              cFalse.wordBookList[index].word,
                            );
                          },
                          child: SizedBox(
                            height: double.infinity,
                            width: 50.h,
                            child: Center(
                              child: Icon(
                                Icons.headset_mic_rounded,
                                size: 34.sp,
                                color: black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () => CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              backgroundColor: Colors.transparent,
                              confirmBtnColor: yellow,
                              confirmBtnTextStyle:
                                  TextStyle(color: Colors.black),
                              lottieAsset: "assets/lotties/alert.json",
                              confirmBtnText: "确定",
                              cancelBtnText: "取消",
                              cancelBtnTextStyle:
                                  TextStyle(color: Colors.black),
                              title:
                                  "要删除 ${cFalse.wordBookList[index].word} 吗?",
                              onConfirmBtnTap: () => {
                                    cFalse.onDeleteWord(context, index),
                                  }),
                          child: SizedBox(
                            height: double.infinity,
                            width: 50.h,
                            child: Center(
                              child: Icon(
                                Ionicons.trash_outline,
                                size: 34.sp,
                                color: black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
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
    );
  }
}
