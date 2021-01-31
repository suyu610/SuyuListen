import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/provider/listen_provider.dart';
import 'package:SuyuListening/ui/components/custom_dialog_box.dart';
import 'package:SuyuListening/ui/components/emoji_feedback.dart';
import 'package:SuyuListening/utils/check_util.dart';
import 'package:SuyuListening/utils/storage_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

class ListenPage extends StatefulWidget {
  ListenPage({Key key}) : super(key: key);

  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  bool isKeyboardVisible = false;
  ReceivePort _port = ReceivePort();

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);

    super.initState();
  }

  // void addHistorySentence() {
  //   Provider.of<ListenProvider>(context, listen: false).switchShowCheckText();
  //   historySentenceList.add(randomAlpha(80));
  //   setState(() {});
  //   historyController.animateTo(
  //     historyController.position.maxScrollExtent, //滚动到底部
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }

  bool popConfirm() {
    CoolAlert.show(
        confirmBtnColor: ThemeColors.colorTheme,
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
          print("确认");
          // 关闭对话框
          Navigator.pop(context);
          // 退回到上一级页面
          Navigator.pop(context);
          return true;
        },
        onConfirmBtnTap: () {
          Navigator.pop(context);
        });
    return false;
  }

  Future<void> download() async {
    String audiosDir = await getAudiosFolderPath();
    print("==============");
    print(audiosDir);
    print("==============");
    final taskId = await FlutterDownloader.enqueue(
      url:
          'https://files.21voa.com/202101/technology-problems-linked-to-higher-stress-levels-in-workers.mp3',
      savedDir: audiosDir,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  void onTapFloatingActionButton() {
    // showCompelete();

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
            text: "反馈",
          );
        });

    // child:

    // Provider.of<ListenProvider>(context, listen: false)
    // .setProgress(Random().nextInt(100));
  }

  void showCompelete() {
    Dialogs.materialDialog(
        color: Colors.white,
        msg: '今日目标达成!',
        title: '真棒!',
        animation: 'assets/lotties/cong_example.json',
        context: context,
        actions: [
          IconsButton(
            onPressed: () {},
            text: '老子真棒',
            iconData: Icons.done,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // 拦截返回
        onWillPop: () async => popConfirm(),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            //点击空白关闭软键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: onTapFloatingActionButton,
              ),
              appBar: AppBar(
                backgroundColor: gradientStartColor,
                elevation: 0,
                title: Text("Website Helps Students Hoping to Attend College",
                    style: TextStyle(fontSize: 24.sp)),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => popConfirm(),
                ),
                actions: [
                  Icon(
                    Icons.menu,
                  ),
                  SizedBox(width: 14.w),
                ],
              ),
              body: Container(
                color: gradientStartColor,
                // height: 200.h,
                child: Column(
                  children: [
                    historyWidget(),
                    ProgressWidget(),
                    _BuildControllerAreaWidget(),
                    buildInputAreaWidget(),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity:
                            Provider.of<ListenProvider>(context, listen: true)
                                    .showCheckText
                                ? 1.0
                                : 0.0,
                        child: StyledText(
                          text:
                              Provider.of<ListenProvider>(context, listen: true)
                                  .checkText,
                          // '<normal>green and </normal><error>red color</error> <miss>hello,world</miss><normal> text.</normal>',
                          styles: {
                            'bold': TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40.sp),
                            'miss': TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: Colors.red,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Colors.transparent),
                            'trans': TextStyle(
                                fontSize: 30.sp,
                                decorationThickness: 2,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Colors.white),
                            'normal': TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                            'error': TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                                decorationColor: Colors.red,
                                decorationStyle: TextDecorationStyle.solid,
                                color: ThemeColors.colorTheme),
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          border: Border(
                              bottom: (BorderSide(
                                  width: 1,
                                  color: Colors.black.withAlpha(50)))),
                        ),
                        child: FAProgressBar(
                          // backgroundColor: Colors.black.withAlpha(180),
                          progressColor: ThemeColors.colorTheme.withAlpha(0),
                          displayTextStyle:
                              TextStyle(color: gradientStartColor),
                          animatedDuration: Duration(seconds: 1),
                          currentValue:
                              Provider.of<ListenProvider>(context, listen: true)
                                  .progress,

                          displayText: '🚩',
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}

// ignore: camel_case_types
class historyWidget extends StatefulWidget {
  historyWidget({Key key}) : super(key: key);
  @override
  _historyWidgetState createState() => _historyWidgetState();
}

// ignore: camel_case_types
class _historyWidgetState extends State<historyWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  ScrollController historyController;
  List<String> historySentenceList = [
    "Technology Report",
    "This is America",
    "Science in the News",
    "Health Report",
    "Education Report",
    "Economics Report",
    "American Mosaic",
    "In the News",
    "American Stories"
  ];
  bool isKeyboardVisible = false;
  @override
  void initState() {
    historyController = ScrollController();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print(visible);
        isKeyboardVisible = visible;
        if (!visible) {
          _animationController.forward();
        } else {
          _animationController.animateBack(0);
        }
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isKeyboardVisible ? 150.h : 250.h,
      duration: Duration(milliseconds: 300),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: ListView.builder(
            controller: historyController,
            itemCount: historySentenceList.length,
            physics: BouncingScrollPhysics(),
            //范围内进行包裹（内容多高ListView就多高）
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                historySentenceList[index],
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 28.sp),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProgressWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProgressWidgetState();
  }
}

// 进度条
class _ProgressWidgetState extends State<ProgressWidget> {
  double _upperValue = 0;
  AudioPlayer player;
  @override
  void initState() {
    player =
        Provider.of<ListenProvider>(context, listen: false).getPlayerInstance();
    // _maxValue = player.duration.inMinutes.toDouble();
    super.initState();
  }

  double _maxValue = 0;
  @override
  Widget build(BuildContext context) {
    if (player.duration != null) {
      print(player.duration.inMilliseconds);
      _maxValue = player.duration.inMilliseconds.toDouble();
      setState(() {});
    } else {
      _maxValue = 100000;
    }
    return Container(
      padding: EdgeInsets.only(right: 6, left: 6),
      child: StreamBuilder<Duration>(
        stream: player.durationStream,
        builder: (context, snapshot) {
          final duration = snapshot.data ?? Duration.zero;
          return StreamBuilder<Duration>(
            stream: player.positionStream,
            builder: (context, snapshot) {
              var position = snapshot.data ?? Duration.zero;
              if (position > duration) {
                position = duration;
              }
              //  return SeekBar(
              //   duration: duration,
              //   position: position,
              //   onChangeEnd: (newPosition) {
              //     _player.seek(newPosition);
              //   },
              // );
              // print("===============");
              // print("duration:");
              // print(duration);
              // print("position:");
              // print(position);
              // print("===============");
              // final Duration duration;
              // final Duration position;
              // final ValueChanged<Duration> onChanged;
              // final ValueChanged<Duration> onChangeEnd;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50.h,
                    child: FlutterSlider(
                      handler: FlutterSliderHandler(
                        decoration: BoxDecoration(),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(width: 2)),
                            child: Icon(
                              Icons.play_arrow,
                              size: 40.sp,
                            )),
                      ),
                      tooltip: FlutterSliderTooltip(disabled: true),
                      jump: true,
                      trackBar: FlutterSliderTrackBar(
                        inactiveTrackBarHeight: 10.h,
                        activeTrackBarHeight: 10.h,
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        activeTrackBar: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: ThemeColors.colorTheme),
                      ),
                      values: [
                        (player.position ?? Duration(milliseconds: 100000))
                            .inMilliseconds
                            .toDouble(),
                        (player.duration ?? Duration(milliseconds: 100000))
                            .inMilliseconds
                            .toDouble()
                      ],
                      max:
                          _maxValue, //player.duration.inMilliseconds.toDouble() ?? 0,
                      min: 0,
                      maximumDistance: 10000,
                      rtl: false,
                      handlerAnimation: FlutterSliderHandlerAnimation(
                          curve: Curves.elasticOut,
                          reverseCurve: null,
                          duration: Duration(milliseconds: 700),
                          scale: 1.4),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        _upperValue = lowerValue;
                        print(lowerValue);
                        player
                            .seek(Duration(milliseconds: (lowerValue).round()));
                        setState(() {});
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 18.0),
                        child: Text(
                          (position.inSeconds ~/ 60).toString() +
                              ":" +
                              (((position.inSeconds % 60) < 10)
                                  ? "0" + (position.inSeconds % 60).toString()
                                  : (position.inSeconds % 60).toString()),
                          style:
                              TextStyle(fontSize: 24.sp, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(
                          (duration.inSeconds ~/ 60).toString() +
                              ":" +
                              (((duration.inSeconds % 60) < 10)
                                  ? "0" + (duration.inSeconds % 60).toString()
                                  : (duration.inSeconds % 60).toString()),
                          style:
                              TextStyle(fontSize: 24.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _BuildControllerAreaWidget extends StatefulWidget {
  _BuildControllerAreaWidget({Key key}) : super(key: key);

  @override
  __BuildControllerAreaWidgetState createState() =>
      __BuildControllerAreaWidgetState();
}

class __BuildControllerAreaWidgetState
    extends State<_BuildControllerAreaWidget> {
  AudioPlayer _player;

  @override
  void initState() {
    _player =
        Provider.of<ListenProvider>(context, listen: false).getPlayerInstance();
    super.initState();
  }

  String localFilePath = "";

  Future _loadFile() async {
    String audioPath = await getAudiosFolderPath();
    final file = File(
        '$audioPath/technology-problems-linked-to-higher-stress-levels-in-workers.mp3');
    if (await file.exists()) {
      setState(() {
        localFilePath = file.path;
      });
    } else {
      print("文件不存在");
    }
  }

  playLocal() async {
    await _loadFile();
    await _player.setFilePath(localFilePath);
    _player.seek(duration);
    _player.play();
  }

  Duration duration = Duration(microseconds: 0);
  pause() async {
    duration = _player.position;
    _player.pause();
  }

  bool isPlaying = false;
  void onTapPlayButton() {
    if (isPlaying) {
      pause();
    } else {
      playLocal();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return // 控制区域
        Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      width: 750.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Icon(
                Icons.repeat,
                color: Colors.white,
              ),
              Text(
                "重复单句",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.skip_previous_outlined,
                color: Colors.white,
              ),
              Text(
                "上一句",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          GestureDetector(
            onTap: onTapPlayButton,
            child: Column(
              children: [
                Icon(
                  isPlaying ? Ionicons.pause_circle : Ionicons.play_circle,
                  color: Colors.white,
                  size: 106.sp,
                )
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                Icons.skip_next_outlined,
                color: Colors.white,
              ),
              Text(
                "下一句",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Column(
            children: [
              Icon(
                Ionicons.rocket_outline,
                color: Colors.white,
              ),
              Text(
                "倍速",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class buildInputAreaWidget extends StatefulWidget {
  buildInputAreaWidget({Key key}) : super(key: key);

  @override
  _buildInputAreaWidgetState createState() => _buildInputAreaWidgetState();
}

// ignore: camel_case_types
class _buildInputAreaWidgetState extends State<buildInputAreaWidget> {
  TextEditingController textfieldController;
  @override
  void initState() {
    textfieldController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 2),
      ),
      child: new ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 300.h, maxWidth: 730.w),
        child: new TextField(
          autofocus: true,
          controller: textfieldController,
          onChanged: (str) {
            var rightStr = myTrim("hello , my name is hpy");
            var outputStr = checkStr(textfieldController.text, rightStr);
            // TODO
            // 检查拼写,如果正确，则清空，并跳转到下一句
            if (outputStr == rightStr) {
              // TODO
              // 显示原文和翻译
              EasyLoading.showSuccess("真棒!!!!").then((value) => {
                    Provider.of<ListenProvider>(context, listen: false)
                        .setCheckText(
                            "<normal>hello! my name is hpy</normal>  <trans>译:你好！我的名字是黄鹏宇</trans>"),
                    Future.delayed(const Duration(milliseconds: 2000), () {
                      textfieldController.text = "";
                    })
                  });
            }
            // 如果错误，应该
            else {
              Provider.of<ListenProvider>(context, listen: false)
                  .setCheckText(outputStr);
              Provider.of<ListenProvider>(context, listen: false)
                  .setShowCheckText();
              // EasyLoading.showError("有错误");
            }
          },
          maxLines: 4,
          minLines: 1,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.go,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                Ionicons.key_outline,
                size: 26.sp,
              ),
              onPressed: () => {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.confirm,
                    backgroundColor: Colors.transparent,
                    confirmBtnColor: ThemeColors.colorTheme,
                    confirmBtnTextStyle: TextStyle(color: Colors.black),
                    lottieAsset: "assets/lotties/money.json",
                    confirmBtnText: "确定",
                    cancelBtnText: "取消",
                    cancelBtnTextStyle: TextStyle(color: Colors.black),
                    text: "花 1 个积分，来查看此句?",
                    title: "垃圾",
                    onConfirmBtnTap: () => {
                          Navigator.pop(context),
                          Provider.of<ListenProvider>(context, listen: false)
                              .setShowCheckText(),
                          Provider.of<ListenProvider>(context, listen: false)
                              .setCheckText(
                                  "<normal>hello! my name is hpy                                        </normal><trans>译:你好！我的名字是黄鹏宇</trans>"),
                        }),
              },
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
            hintText: '在此输入',
            prefixIcon: Icon(
              Icons.edit,
              size: 26.sp,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Slider(
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble()),
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd(Duration(milliseconds: value.round()));
            }
            _dragValue = null;
          },
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}
