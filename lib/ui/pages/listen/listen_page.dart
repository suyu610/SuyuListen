// dart库
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

// 第三方库
import 'package:SuyuListening/provider/listen_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// 本包下的库
import '../../../constant/theme_color.dart';
import '../../components/tap_blank_fold_keyboard_gesture.dart';
import '../../components/dialog/custom_dialog_box.dart';
import '../../components/dialog/emoji_feedback.dart';

// 本目录下的
import 'listen.dart';

class ListenPage extends StatefulWidget {
  ListenPage({Key key}) : super(key: key);

  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  /// 定义变量
  ///
  ReceivePort _port = ReceivePort();

  /// 生命周期函数
  ///
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // ignore: unused_local_variable
      String id = data[0];
      // ignore: unused_local_variable
      DownloadTaskStatus status = data[1];
      // ignore: unused_local_variable
      int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  /// 自定义函数
  ///
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void onTapFloatingActionButton() {
    //庆祝
    Provider.of<ListenProvider>(context, listen: false)
        .confettiController
        .play();
    // child:
    Future.delayed(Duration(seconds: 3), showCompelete);
    // Provider.of<ListenProvider>(context, listen: false)
    // .setProgress(Random().nextInt(100));
  }

  // 完成时候的对话框
  void showCompelete() {
    Dialogs.materialDialog(
        color: Colors.white,
        msg: '今日目标达成!\n他还只完成了57%',
        title: '真棒!',
        animation: 'assets/lotties/cong_example.json',
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialogBox(
                      title: "这篇文章难度怎么样?",
                      contentWidget: EmojiFeedback(
                        onChange: (index) {
                          print(index);
                        },
                      ),
                      text: "提交",
                    );
                  });
            },
            text: '我真棒',
            iconData: Icons.star,
            color: blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
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
          Navigator.pop(context);
          // 退回到上一级页面
          // Navigator.pop(context);
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
                  child: Column(
                    children: [
                      HistoryWidget(),
                      ProgressWidget(),
                      ControllerAreaWidget(),
                      InputAreaWidget(),
                      CountdownWidget(),
                    ],
                  ),
                ),
                // 庆祝动画
                Align(
                  alignment: Alignment.center,
                  child: ConfettiWidget(
                      confettiController:
                          Provider.of<ListenProvider>(context, listen: false)
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
