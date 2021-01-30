import 'dart:async';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/provider/listen_provider.dart';
import 'package:SuyuListening/utils/check_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:ionicons/ionicons.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListenPage extends StatefulWidget {
  ListenPage({Key key}) : super(key: key);

  @override
  _ListenPageState createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  bool isKeyboardVisible = false;
  @override
  void initState() {
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
              // floatingActionButton: FloatingActionButton(
              //   onPressed: addHistorySentence,
              // ),
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
                    _buildControllerAreaWidget(),
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
                    )
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
  double _maxValue = 100;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 6, left: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            // color: Colors.black,
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
              values: [_upperValue, _upperValue],
              max: _maxValue,
              min: 0,
              maximumDistance: 300,
              rtl: false,
              handlerAnimation: FlutterSliderHandlerAnimation(
                  curve: Curves.elasticOut,
                  reverseCurve: null,
                  duration: Duration(milliseconds: 700),
                  scale: 1.4),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                _upperValue = lowerValue;
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
                  (_upperValue ~/ 59).toString() +
                      ":" +
                      NumUtil.getNumByValueDouble((_upperValue % 59), 0)
                          .toString(),
                  style: TextStyle(fontSize: 24.sp, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(
                  (_maxValue ~/ 59).toString() +
                      ":" +
                      NumUtil.getNumByValueDouble((_maxValue % 59), 0)
                          .toString(),
                  style: TextStyle(fontSize: 24.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 控制区域
Widget _buildControllerAreaWidget() {
  return Container(
    margin: EdgeInsets.only(top: 10, bottom: 10),
    width: 750.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: Column(
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
        ),
        Expanded(
          flex: 2,
          child: Column(
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
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Icon(
                Ionicons.play_circle,
                color: Colors.white,
                size: 106.sp,
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
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
        ),
        Expanded(
          flex: 2,
          child: Column(
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
        ),
      ],
    ),
  );
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
