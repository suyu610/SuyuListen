// dart库
import 'dart:async';
import 'dart:ui';
// 第三方库
import 'package:SuyuListening/controller/listen_controller.dart';
import 'package:SuyuListening/entity/entities.dart';
import 'package:confetti/confetti.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// 本包下的库
import '../../../constant/theme_color.dart';
import '../../components/tap_blank_fold_keyboard_gesture.dart';

// 本目录下的
import 'listen.dart';

class ListenPage extends StatefulWidget {
  final ArticleEntity articleEntity;

  ListenPage({this.articleEntity, Key key}) : super(key: key);

  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  /// 生命周期函数
  ///
  @override
  void initState() {
    super.initState();
  }

  Future<bool> getInit() async {
    return await Provider.of<ListenController>(context, listen: false)
        .initController(articleEntity: widget.articleEntity, context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapFloatingActionButton() {
    //庆祝
    Provider.of<ListenController>(context, listen: false)
        .confettiController
        .play();
    Future.delayed(Duration(seconds: 3),
        Provider.of<ListenController>(context, listen: false).showCompelete);
  }

  // 退出时的确认对话框
  bool popConfirm() {
    CoolAlert.show(
        confirmBtnColor: yellow,
        confirmBtnTextStyle: TextStyle(color: Colors.black),
        cancelBtnTextStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.white,
        context: context,
        lottieAsset: "assets/lotties/alert.json",
        title: "垃圾，不学了吗?",
        text: "他已经超过你40%",
        confirmBtnText: "继续学习",
        cancelBtnText: "退出",
        type: CoolAlertType.confirm,
        onCancelBtnTap: () {
          // 退出对话框
          Navigator.pop(context);
          // 退回到上一级页面
          Navigator.pop(context);
          // 销毁音频
          Provider.of<ListenController>(context, listen: false)
              .getPlayerInstance()
              .pause();
          return true;
        },
        onConfirmBtnTap: () {
          Navigator.pop(context);
        });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // 拦截返回
        onWillPop: () async => popConfirm(),
        child: FoldKeyboardGestureDetector(
          child: Scaffold(
              floatingActionButton: _buildFloatingActionButton(),
              appBar: _buildListenAppbar(),
              body: Stack(children: [
                Container(
                  color: blue,
                  child: FutureBuilder(
                      future: getInit(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return new Text('Press button to start');
                          case ConnectionState.waiting:
                            return SpinKitFadingCircle(
                              color: Colors.black,
                              size: 30.0,
                            );

                          default:
                            if (snapshot.hasError)
                              return new Text('Error: ${snapshot.error}');
                            else //若_calculation执行正常完成
                              return Column(
                                children: [
                                  HistoryWidget(),
                                  ProgressWidget(),
                                  ControllerAreaWidget(),
                                  InputAreaWidget(),
                                  CountdownWidget(),
                                ],
                              );
                        }
                      }),
                ),

                // 庆祝动画
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                      confettiController:
                          Provider.of<ListenController>(context, listen: false)
                              .confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: false,
                      numberOfParticles: 20,
                      colors:
                          confettiColors // manually specify the colors to be used
                      ),
                ),
              ])),
        ));
  }

  AppBar _buildListenAppbar() => AppBar(
        backgroundColor: blue,
        elevation: 0,
        title: Text("Website Helps Students Hoping to Attend College",
            style: TextStyle(fontSize: 24.sp, color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => popConfirm(),
        ),
        actions: [
          Icon(Icons.menu, color: Colors.white),
          SizedBox(width: 14.w),
        ],
      );
  FloatingActionButton _buildFloatingActionButton() => FloatingActionButton(
        child: Text("完成", style: TextStyle(color: Colors.black)),
        backgroundColor: yellow,
        onPressed: onTapFloatingActionButton,
      );
}
