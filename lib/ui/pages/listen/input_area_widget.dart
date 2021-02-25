import 'package:SuyuListening/constant/theme_color.dart';
import 'package:SuyuListening/controller/listen_controller.dart';
import 'package:SuyuListening/ui/components/keyboard_actions.dart/keyboard_actions.dart';
import 'package:SuyuListening/utils/check_util.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

import 'keyboard_actions.dart';

// ignore: camel_case_types
class InputAreaWidget extends StatefulWidget {
  InputAreaWidget({Key key}) : super(key: key);
  @override
  _InputAreaWidgetState createState() => _InputAreaWidgetState();
}

// ignore: camel_case_types
class _InputAreaWidgetState extends State<InputAreaWidget> {
  TextEditingController textfieldController;

  final FocusNode keyboardNode = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Provider.of<ListenController>(context, listen: true)
          .keyboardActionAreaColor,
      nextFocus: false,

      // 键盘上方的功能区
      actions: keyboardActionsItem(keyboardNode),
    );
  }

  @override
  void initState() {
    textfieldController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350.h,
        margin: EdgeInsets.only(right: 10, left: 10, top: 15.h),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(6),
        // ),
        child: KeyboardActions(
          config: _buildConfig(context),
          child: new TextField(
            autofocus: false,
            focusNode: keyboardNode,
            controller: textfieldController,
            onChanged: (str) {
              var rightStr = myTrim("hello , my name is hpy");
              var outputStr = checkStr(textfieldController.text, rightStr);
              // TODO
              // 检查拼写,如果正确，则清空，并跳转到下一句
              if (outputStr == rightStr) {
                Provider.of<ListenController>(context, listen: false).success();
                EasyLoading.showSuccess("真棒!!!!").then((value) => {
                      Provider.of<ListenController>(context, listen: false)
                          .setCheckText('''
<normal>hello! my name is hpy</normal>  
\n<trans>\n【 译:你好！我的名字是黄鹏宇 】</trans>
                              '''),
                      Future.delayed(const Duration(milliseconds: 2000), () {
                        textfieldController.text = "";
                      })
                    });
              }
              // 如果错误，应该
              else {
                Provider.of<ListenController>(context, listen: false)
                    .setCheckText(outputStr);
                Provider.of<ListenController>(context, listen: false)
                    .setShowCheckText();
                // EasyLoading.showError("有错误");
              }
              setState(() {});
            },
            maxLines: 4,
            minLines: 1,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.go,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Ionicons.key_outline,
                  size: 26.sp,
                  color: Colors.black,
                ),
                onPressed: () => {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.confirm,
                      backgroundColor: Colors.white,
                      confirmBtnColor: yellow,
                      confirmBtnTextStyle: TextStyle(color: Colors.black),
                      lottieAsset: "assets/lotties/money.json",
                      confirmBtnText: "确定",
                      cancelBtnText: "取消",
                      cancelBtnTextStyle: TextStyle(color: Colors.black),
                      text: "花 1 个积分，来查看此句?",
                      title: "垃圾",
                      onConfirmBtnTap: () => {
                            Navigator.pop(context),
                            Provider.of<ListenController>(context,
                                    listen: false)
                                .setShowCheckText(),
                            Provider.of<ListenController>(context,
                                    listen: false)
                                .setCheckText('''
<normal>hello! my name is hpy</normal>
                                    \n<trans>\n译:你好！我的名字是黄鹏宇</trans>
                                    '''),
                          }),
                },
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
              hintText: '在此输入',
              prefixIcon: Icon(
                Icons.edit,
                size: 26.sp,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: silver,
            ),
          ),
        ));
  }
}
