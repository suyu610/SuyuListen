import 'package:SuyuListening/controller/wordbook_controller.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstWordBookPage extends StatefulWidget {
  FirstWordBookPage(this.floatingSearchBarController, {Key key})
      : super(key: key);
  final FloatingSearchBarController floatingSearchBarController;

  @override
  _FirstWordBookPageState createState() => _FirstWordBookPageState();
}

class _FirstWordBookPageState extends State<FirstWordBookPage> {
  WordBookController wordBookController;

  @override
  void initState() {
    wordBookController =
        Provider.of<WordBookController>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _lastTime; //上次滑动的时间

    ScrollController _scrollController = new ScrollController();
    // 应该只让他监听一次

    _scrollController.addListener(() {
      if ((_scrollController.position.pixels < -40) &&
          (_lastTime == null ||
              DateTime.now().difference(_lastTime) > Duration(seconds: 1))) {
        _lastTime = DateTime.now();
        if (!wordBookController.floatingSearchBarController.isOpen) {
          wordBookController.floatingSearchBarController.open();
        }
      }
    });

    //当滚动
    _onUpdateScroll(ScrollMetrics metrics) {
      if (_scrollController.position.pixels > 0) {
        if (widget.floatingSearchBarController.isOpen) {
          wordBookController.floatingSearchBarController.close();
        }
      }
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 100.h),
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            _onUpdateScroll(scrollNotification.metrics);
          }
          // 不拦截
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          itemCount: 100,
          itemBuilder: (context, index) {
            return Card(
              shape: SuperellipseShape(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 1.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  onTap: () {
                    wordBookController.onTapListTile(index, context);
                  },
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Text(
                    index.toString(),
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 48.sp,
                        fontWeight: FontWeight.normal),
                  ),
                  title: AnimatedOpacity(
                    opacity:
                        Provider.of<WordBookController>(context, listen: true)
                                    .showDefinitionMode !=
                                DefinitinoEnum.CH
                            ? 1.0
                            : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Row(
                      children: [
                        Text(
                          "abandon",
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.gamepad,
                          size: 30.sp,
                        ),
                      ],
                    ),
                  ),
                  subtitle: AnimatedOpacity(
                    opacity:
                        Provider.of<WordBookController>(context, listen: true)
                                    .showDefinitionMode !=
                                DefinitinoEnum.ENG
                            ? 1.0
                            : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      "抛弃放弃吧啦吧啦吧觉得撒飞机撒的",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.headset_mic_rounded,
                        size: 30.sp,
                        color: Colors.grey[400],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Icon(
                        Ionicons.chevron_forward,
                        size: 34.sp,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
