import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/controller/wordbook_controller.dart';
import 'package:SuyuListening/entity/entities.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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
                    return ListView.builder(
                        padding: EdgeInsets.fromLTRB(10.w, 4, 10.w, 4),
                        scrollDirection: Axis.vertical,
                        controller: wordBookController.scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: Provider.of<WordBookController>(context,
                                listen: true)
                            .wordBookList
                            .length, //
                        itemBuilder: (context, index) => wordbookListItem(
                            context,
                            index,
                            wordBookController,
                            colorItems,
                            _borderRadius));
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
                })));
  }

  Widget wordbookListItem(
          BuildContext context,
          int index,
          WordBookController wordBookController,
          List<RandomGradientColor> colorItems,
          double _borderRadius) =>
      GestureDetector(
        onTap: () {
          wordBookController.onTapListTile(index, context);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
            child: Stack(
              children: <Widget>[
                Material(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: SuperellipseShape(
                      borderRadius: BorderRadius.circular(40)),
                  child: Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        colorItems[index % 3].startColor,
                        colorItems[index % 3].endColor
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
                        child: Provider.of<WordBookController>(context,
                                    listen: true)
                                .wordBookList[index]
                                .tempIsCompelete
                            ? Icon(Icons.check, color: Colors.white, size: 30)
                            : Icon(Icons.radio_button_unchecked,
                                color: Colors.white, size: 30),
                        flex: 2,
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AnimatedOpacity(
                              opacity: Provider.of<WordBookController>(context,
                                                  listen: true)
                                              .showDefinitionMode !=
                                          DefinitinoEnum.CH ||
                                      Provider.of<WordBookController>(context,
                                              listen: true)
                                          .wordBookList[index]
                                          .tempIsCompelete
                                  ? 1.0
                                  : 0.0,
                              duration: Duration(milliseconds: 500),
                              child: Text(
                                Provider.of<WordBookController>(context,
                                        listen: false)
                                    .wordBookList[index]
                                    .word,
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
                              opacity: Provider.of<WordBookController>(context,
                                                  listen: true)
                                              .showDefinitionMode !=
                                          DefinitinoEnum.ENG ||
                                      Provider.of<WordBookController>(context,
                                              listen: true)
                                          .wordBookList[index]
                                          .tempIsCompelete
                                  ? 1.0
                                  : 0.0,
                              duration: Duration(milliseconds: 500),
                              child: Text(
                                wordBookController
                                    .wordBookList[index].definition,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                wordBookController.tapPlayAudioButton(
                                  wordBookController.wordBookList[index].word,
                                );
                              },
                              child: SizedBox(
                                height: double.infinity,
                                width: 50.h,
                                child: Center(
                                  child: Icon(
                                    Icons.headset_mic_rounded,
                                    size: 34.sp,
                                    color: Colors.white,
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
                                      "要删除 ${wordBookController.wordBookList[index].word} 吗?",
                                  onConfirmBtnTap: () => {
                                        wordBookController.onDeleteWord(
                                            context, index),
                                      }),
                              child: SizedBox(
                                height: double.infinity,
                                width: 50.h,
                                child: Center(
                                  child: Icon(
                                    Ionicons.trash_outline,
                                    size: 34.sp,
                                    color: Colors.white,
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
        ),
      );
}
